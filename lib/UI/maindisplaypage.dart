import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/UI/AllBooksPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'Book_info.dart';
import 'AddBookPage.dart';
import '../Models/Book_info_model.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:getwidget/getwidget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Notifications.dart';
import  'AddBookPage.dart';

final _firestore = FirebaseFirestore.instance;
class maindisplaypage extends StatefulWidget {
  static String id = 'maindisplaypage_Screen';

  @override
  _maindisplaypageState createState() => _maindisplaypageState();
}

class _maindisplaypageState extends State<maindisplaypage> {

  List<String> Homepage_Cat = [];
  List<homepage_items_featured> featured = [];
  List<homepage_items_featured> latestbooks = [];
  List<homepage_items_featured> BestRated = [];
  List<homepage_items_featured> booksForYou = [];
  List TotalBookName = [];
  List TotalBookCollID=[];
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    //initiaise to get list of homepage categories from database

    AwesomeNotifications().initialize(
        'resource://drawable/res_app_icon',
        [
          // Your notification channels go here
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white
          )
        ]
    );
    Notifications.init();
    // FirebaseMessaging.onMessage.listen(_firebaseonforegrounfHandler);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


    setState(() {
      home_cat_get();
      Category_items();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var floatingButtons = List<UnicornButton>();
    floatingButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Add Books(Rent)",
        currentButton: FloatingActionButton(
          onPressed: () {
            print('add books rent');
            //Navigator.pushNamed(context, AddBookPage.id);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNewBook()));
          },
          heroTag: "addrentbooks",
          backgroundColor: Colors.deepOrange,
          mini: true,
          child: Icon(Icons.note_add),
        ),
      ),
    );
    // floatingButtons.add(
    //   UnicornButton(
    //     hasLabel: true,
    //     labelText: "Add Books(Sell)",
    //     currentButton: FloatingActionButton(
    //       onPressed: () {
    //         print('addbooksell');
    //         Navigator.pushNamed(context, AddBookPage.id);
    //       },
    //       heroTag: "addbookssell",
    //       backgroundColor: Colors.orange,
    //       mini: true,
    //       child: Icon(Icons.note_add),
    //     ),
    //   ),
    // );
    if (Homepage_Cat.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            "Fetching Data!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: UnicornDialer(
            backgroundColor: Colors.transparent,
            parentButtonBackground: Colors.amber,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.playlist_add_sharp),
            childButtons: floatingButtons),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GFSearchBar(
                searchList: TotalBookName,
                searchQueryBuilder: (query, list) {
                  return list
                      .where((item) =>
                      item.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                },
                overlaySearchListItemBuilder: (item) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
                onItemSelected: (item) {
                  int index=TotalBookName.indexOf(item);
                  _firestore.collection("Book_Collection").doc(TotalBookCollID[index]).get().then((i) {
                    String bkname = i.get("BookName");
                    String author = i.get("Author");
                    String ImageUrl = i.get("ImageUrl");
                    int likes = i.get("Likes");
                    int dislikes = i.get("Dislikes");
                    double mrp = i.get("MRP");
                    double quotedPrice=i.get("QuotedDeposit");
                    String coll_type = i.get("Homepage_category");
                    String original_loc = i.id.toString().trim();
                    String owneruid = i.get("OwnerUID");
                    String selleraddress = i.get("seller_address");
                    String sellerphn = i.get("seller_phoneNumber");
                    bool availability = i.get("Availability");
                    String sellerFullname = i.get("SellerFullName");
                    List homepage_tag_cat = i.get("tags");
                    String sellerUPI=i.get("seller_UPI");
                    List genretags=[""];

                    try{
                      genretags=i.get("Genretags");
                    }catch(e){
                      print(e);
                    }
                    Navigator.pushNamed(context, Book_info.id,
                        arguments: maindisp_book_info_model(
                            homepage_items_featured(
                                author,
                                bkname,
                                coll_type,
                                ImageUrl,
                                likes,
                                dislikes,
                                mrp,
                                quotedPrice,
                                original_loc,
                                owneruid,
                                selleraddress,
                                sellerphn,
                                availability,
                                sellerFullname,
                                sellerUPI,
                                genretags
                            )));
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Homepage_Cat.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 18),
                          child: Text(
                            Homepage_Cat[index],
                            style: TextStyle(
                                fontFamily: "LeelawUI",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Homepage_Cat[index]=="Books For You"?
                        Container(
                          height: 210,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: booksForYou.length+1,
                              itemBuilder: (context, itemIndex) {
                                return itemIndex>booksForYou.length-1?Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap:(){
                                          //GOTO VIEW ALL PAGE
                                          Navigator.pushNamed(context, AllBooksPage.id);
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.amberAccent,
                                              child: Icon(Icons.remove_red_eye_rounded,color: Colors.white,),
                                              radius: 35,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("See all"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,)
                                  ],
                                ):InkWell(
                                  onTap: () {
                                    //goto book info page
                                    Navigator.pushNamed(context, Book_info.id,
                                        arguments: maindisp_book_info_model(
                                            booksForYou[itemIndex]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                          ),
                                          child: Container(
                                            height: 140,
                                            width: 100,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              child: Image.network(
                                                booksForYou[itemIndex].ImageURl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Center(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 16.0),
                                              text:TextSpan(
                                                text: booksForYou[itemIndex].BookName,
                                                style: TextStyle(color: Colors.black87,),
                                              ) ,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Center(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 14.0),
                                              text:TextSpan(
                                                text: booksForYou[itemIndex].Author,
                                                style: TextStyle(color: Colors.grey,
                                                    fontFamily: "LeelawUI"),
                                              ) ,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ):
                      Homepage_Cat[index]=="Featured"?
                        Container(
                          height: 210,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: featured.length+1,
                              itemBuilder: (context, itemIndex) {
                                return itemIndex>featured.length-1?Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap:(){
                                          //GOTO VIEW ALL PAGE
                                          Navigator.pushNamed(context, AllBooksPage.id);
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.amberAccent,
                                              child: Icon(Icons.remove_red_eye_rounded,color: Colors.white,),
                                              radius: 35,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("See all"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,)
                                  ],
                                ):InkWell(
                                  onTap: () {
                                    //goto book info page
                                    Navigator.pushNamed(context, Book_info.id,
                                        arguments: maindisp_book_info_model(
                                            featured[itemIndex]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                          ),
                                          child: Container(
                                            height: 140,
                                            width: 100,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              child: Image.network(
                                                featured[itemIndex].ImageURl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Center(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 16.0),
                                              text:TextSpan(
                                                text: featured[itemIndex].BookName,
                                                style: TextStyle(color: Colors.black87,),
                                              ) ,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Center(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 14.0),
                                              text:TextSpan(
                                                text: featured[itemIndex].Author,
                                                style: TextStyle(color: Colors.grey,
                                                    fontFamily: "LeelawUI"),
                                              ) ,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ):Homepage_Cat[index]=="Latest Books"?
                        Container(
                          height: 210,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: latestbooks.length+1,
                              itemBuilder: (context, itemIndex) {
                                return itemIndex>latestbooks.length-1?Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap:(){
                                          //GOTO VIEW ALL PAGE
                                          Navigator.pushNamed(context, AllBooksPage.id);

                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.amberAccent,
                                              child: Icon(Icons.remove_red_eye_rounded,color: Colors.white,),
                                              radius: 35,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("See all"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,)
                                  ],
                                ):InkWell(
                                  onTap: () {
                                    //goto book info page
                                    Navigator.pushNamed(context, Book_info.id,
                                        arguments: maindisp_book_info_model(
                                            latestbooks[itemIndex]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                          ),
                                          child: Container(
                                            height: 140,
                                            width: 100,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              child: Image.network(
                                                latestbooks[itemIndex].ImageURl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Center(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 16.0),
                                              text:TextSpan(
                                                text: latestbooks[itemIndex].BookName,
                                                style: TextStyle(color: Colors.black87,),
                                              ) ,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Center(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 14.0),
                                              text:TextSpan(
                                                text: latestbooks[itemIndex].Author,
                                                style: TextStyle(color: Colors.grey,
                                                    fontFamily: "LeelawUI"),
                                              ) ,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ):
                        Container(
                          height: 210,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: BestRated.length+1,
                              itemBuilder: (context, itemIndex) {
                                return itemIndex>BestRated.length-1?Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap:(){
                                          //GOTO VIEW ALL PAGE
                                          Navigator.pushNamed(context, AllBooksPage.id);

                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.amberAccent,
                                              child: Icon(Icons.remove_red_eye_rounded,color: Colors.white,),
                                              radius: 35,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("See all"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,)
                                  ],
                                ): InkWell(
                                  onTap: () {
                                    //goto book info page
                                    Navigator.pushNamed(context, Book_info.id,
                                        arguments: maindisp_book_info_model(
                                            BestRated[itemIndex]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                          ),
                                          child: Container(
                                            height: 140,
                                            width: 100,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              child: Image.network(
                                                BestRated[itemIndex].ImageURl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Center(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 16.0),
                                              text:TextSpan(
                                                text: BestRated[itemIndex].BookName,
                                                style: TextStyle(color: Colors.black87,),
                                              ) ,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Center(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 14.0),
                                              text:TextSpan(
                                                text: BestRated[itemIndex].Author,
                                                style: TextStyle(color: Colors.grey,
                                                    fontFamily: "LeelawUI"),
                                              ) ,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),

                      ],
                    );
                  }),
            ),
          ],
        ),
      );
  }

  void Category_items() async {
    try {
      await _firestore
          .collection("Book_Collection")
          .where("OwnerUID",isNotEqualTo: FirebaseAuth.instance.currentUser.uid)
          .where("adminapproval", isEqualTo: 1)
          .get()
          .then((value) {
        for (var i in value.docs) {

          String bkname = i.get("BookName");
          String author = i.get("Author");
          String ImageUrl = i.get("ImageUrl");
          int likes = i.get("Likes");
          int dislikes = i.get("Dislikes");
          double mrp = i.get("MRP");
          double quotedPrice=i.get("QuotedDeposit");
          String coll_type = i.get("Homepage_category");
          String original_loc = i.id.toString().trim();
          String owneruid = i.get("OwnerUID");
          String selleraddress = i.get("seller_address");
          String sellerphn = i.get("seller_phoneNumber");
          bool availability = i.get("Availability");
          String sellerFullname = i.get("SellerFullName");
          String sellerUPI=i.get("seller_UPI");
          List homepage_tag_cat = i.get("tags");
          List GenreTags=[""];
          try{
            GenreTags=i.get("Genretags");
          }catch(e){
            print(e);
          }
          TotalBookName.add(bkname);
          TotalBookCollID.add(i.id);
          if (homepage_tag_cat.contains("booksforyou")) {
            booksForYou.add(homepage_items_featured(
                author,
                bkname,
                coll_type,
                ImageUrl,
                likes,
                dislikes,
                mrp,
                quotedPrice,
                original_loc,
                owneruid,
                selleraddress,
                sellerphn,
                availability,
                sellerFullname,
                sellerUPI,
                GenreTags));
          }
          if (homepage_tag_cat.contains("featured")) {
            featured.add(homepage_items_featured(
                author,
                bkname,
                coll_type,
                ImageUrl,
                likes,
                dislikes,
                mrp,
                quotedPrice,
                original_loc,
                owneruid,
                selleraddress,
                sellerphn,
                availability,
                sellerFullname,
                sellerUPI,
                GenreTags));
          }
          if (homepage_tag_cat.contains("latest books")) {
            latestbooks.add(homepage_items_featured(
                author,
                bkname,
                coll_type,
                ImageUrl,
                likes,
                dislikes,
                mrp,
                quotedPrice,
                original_loc,
                owneruid,
                selleraddress,
                sellerphn,
                availability,
                sellerFullname,
                sellerUPI,
                GenreTags));
          }
          if (homepage_tag_cat.contains("best rated")) {
            BestRated.add(homepage_items_featured(
                author,
                bkname,
                coll_type,
                ImageUrl,
                likes,
                dislikes,
                mrp,
                quotedPrice,
                original_loc,
                owneruid,
                selleraddress,
                sellerphn,
                availability,
                sellerFullname,
                sellerUPI,
                GenreTags));
          }
        }
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }
  void home_cat_get() async {
    try {
      await _firestore.collection("Homepage_item_list").get().then((value) {
        for (var i in value.docs) {
          Homepage_Cat.add(i.get("Name"));
        }
        setState(() {});
      });
    } catch (e) {
      print("Error" + e.message);
    }

    print(Homepage_Cat);
  }
}



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  // Use this method to automatically convert the push data, in case you gonna use our data standard
  AwesomeNotifications().createNotificationFromJsonData(message.data);

}
