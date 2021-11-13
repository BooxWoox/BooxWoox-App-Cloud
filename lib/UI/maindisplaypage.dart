import 'package:bookollab/Api/books.dart';
import 'package:bookollab/Models/book.dart';
import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/State/auth.dart';
import 'package:bookollab/State/search.dart';
import 'package:bookollab/UI/AllBooksPage.dart';
import 'package:bookollab/UI/Book_individual_view.dart';
import 'package:bookollab/UI/Filters/filters.dart';
// import 'package:bookollab/UI/Profile/My_Books.dart';
import 'package:bookollab/UI/See_all.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'Book_info.dart';
import 'AddBookPage.dart';
import '../Models/Book_info_model.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:getwidget/getwidget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Notifications.dart';
import 'AddBookPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bookollab/UI/Notification/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Onboarding/LoginSecureDetails.dart';
import 'Onboarding/SplashScreen.dart';

List book1 = ['abc', 'xyz'];
final List<String> imageList = [
  "https://www.setaswall.com/wp-content/uploads/2018/08/Spiderman-Wallpaper-76-1280x720.jpg",
  "https://images.hdqwalls.com/download/spiderman-peter-parker-standing-on-a-rooftop-ix-1280x720.jpg",
  "https://images.wallpapersden.com/image/download/peter-parker-spider-man-homecoming_bGhsa22UmZqaraWkpJRmZ21lrWxnZQ.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",
];

final _firestore = FirebaseFirestore.instance;

class maindisplaypage extends StatefulWidget {
  static String id = 'maindisplaypage_Screen';

  @override
  _maindisplaypageState createState() => _maindisplaypageState();
}

class _maindisplaypageState extends State<maindisplaypage> {
  List<String> Homepage_Cat = [];
  List<homepage_items_featured> featured = [];
  List<LatestBooks> latestbooks = [];
  List<homepage_items_featured> BestRated = [];
  List<homepage_items_featured> booksForYou = [];
  List TotalBookName = [];
  List TotalBookCollID = [];
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String ftoken = "";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initBooks() async {
    // '233b8ea3-4cc5-45b1-8a99-6753431dab27';
    final apiprovider = context.read(apiProvider);
    ftoken = apiprovider.token;
    var result = await BooksRepository.HomeBooks(ftoken, ['thriller']);
    if (result == Null) {
      print('NULL');
    }

    //var lresult = await BooksRepository.GetLatestBooks(ftoken, '10');

    setState(() {
      booksForYou = result;
     // latestbooks = lresult;
      print(booksForYou.length);
    });
    // return apiprovider.token;
  }

  @override
  void initState() {
    //initiaise to get list of homepage categories from database
    /* var token = 'ada655e2-9c81-482e-88b3-769a722db963';
    List genre = ['thriller', 'action'];
    BooksRepository.HomeBooks(token, genre); */

    //featured = bookdata;
    var token = initBooks();
    print(booksForYou.length);
    AwesomeNotifications().initialize('resource://drawable/res_app_icon', [
      // Your notification channels go here
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ]);
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
        labelText: "Add Books",
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
        // appBar: AppBar(
        //   leading: Icon(Icons.add)
        // ),
        body: Center(
          child: Text(
            "Fetching Data!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            'UIAssets/title.png',
            width: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.fitWidth,
            alignment: Alignment.centerLeft,
          ),
          actions: [
            /*  GestureDetector(
            onTap: () {
              print("userprofile click");
              // Navigator.pushNamed(context, notification.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('No notifications at this time'),
                ),
              );
            },
            child:
                // Image.asset(
                //   'UIAssets/Homepage/notification_icon.png',
                //   color: Colors.black,
                //   fit: BoxFit.scaleDown,
                // ),
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            ),
          ), */
            IconButton(
              icon: Icon(Icons.power_settings_new, color: Colors.black),
              onPressed: () async {
                await LoginSecureDetails.logout();
                Navigator.of(context).pushReplacementNamed(SplashScreen.id);
              },
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Filters.id);
              },
              icon: Icon(Icons.tune, color: Colors.black),
            )
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // shadowColor: Color(0xFFF7C100),
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: UnicornDialer(
            backgroundColor: Colors.transparent,
            parentButtonBackground: Colors.amber,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: floatingButtons),
        body: FloatingSearchBar(
            hint: 'Search your favourite book',
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 16),
            transitionDuration: const Duration(milliseconds: 500),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            axisAlignment: 0.0,
            openAxisAlignment: 0.0,
            width: 600,
            backgroundColor: Color(0xffe9e9e9),
            debounceDelay: const Duration(milliseconds: 500),
            onQueryChanged: (query) {
              context.read(searchHomeDelegateProvider.notifier).updateHomeQuery(
                    query,
                    booksForYou,
                  );
            },
            // Specify a custom transition to be used for
            // animating between opened and closed stated.
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  elevation: 4.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: booksForYou
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              /*  Navigator.of(context).pushNamed(
                                            Book_info.id,
                                            arguments: e.id); */
                            },
                            child: ListTile(
                              title: Text(e.bookTitle),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, top: 60.0),
//               child: GFSearchBar(
//                 searchList: TotalBookName,
//                 searchQueryBuilder: (query, list) {
//                   return list
//                       .where((item) =>
//                           item.toLowerCase().contains(query.toLowerCase()))
//                       .toList();
//                 },
//                 overlaySearchListItemBuilder: (item) {
//                   return Container(
//                     padding: const EdgeInsets.all(8),
//                     child: Text(
//                       item,
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   );
//                 },
//                 onItemSelected: (item) {
//                   int index = TotalBookName.indexOf(item);
//                   _firestore
//                       .collection("Book_Collection")
//                       .doc(TotalBookCollID[index])
//                       .get()
//                       .then((i) {
//                     String bkname = i.get("BookName");
//                     String author = i.get("Author");
//                     String ImageUrl = i.get("ImageUrl");
//                     int likes = i.get("Likes");
//                     int dislikes = i.get("Dislikes");
//                     double mrp = i.get("MRP");
//                     double quotedPrice = i.get("QuotedDeposit");
//                     String coll_type = i.get("Homepage_category");
//                     String original_loc = i.id.toString().trim();
//                     String owneruid = i.get("OwnerUID");
//                     String selleraddress = i.get("seller_address");
//                     String sellerphn = i.get("seller_phoneNumber");
//                     bool availability = i.get("Availability");
//                     String sellerFullname = i.get("SellerFullName");
//                     List homepage_tag_cat = i.get("tags");
//                     String sellerUPI = i.get("seller_UPI");
//                     List genretags = [""];

//                     try {
//                       genretags = i.get("Genretags");
//                     } catch (e) {
//                       print(e);
//                     }
//                     /*  Navigator.pushNamed(context, Book_info.id,
//                         arguments: maindisp_book_info_model(
//                             homepage_items_featured(
// ))); */
//                   });
//                 },
//               ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: Homepage_Cat.length,
                      itemBuilder: (context, index) {
                        /* if (index == 0) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          autoPlay: true,
                        ),
                        items: imageList
                            .map((e) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Image.network(
                                        e,
                                        width: 1000,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      )
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    } else { */
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  Homepage_Cat[index],
                                  style: TextStyle(
                                      fontFamily: "LeelawUI",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Homepage_Cat[index] == "Books For You"
                                ? Container(
                                    height: 210,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: booksForYou.length + 1,
                                        itemBuilder: (context, itemIndex) {
                                          return itemIndex >
                                                  booksForYou.length - 1
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          //GOTO VIEW ALL PAGE
                                                          Navigator.pushNamed(
                                                            context,
                                                            SeeAll.id,
                                                            arguments: ftoken,
                                                          );
                                                        },
                                                        child: Column(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .amberAccent,
                                                              child: Icon(
                                                                Icons
                                                                    .remove_red_eye_rounded,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              radius: 35,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "See all"),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    //goto book info page
                                                    Navigator.pushNamed(
                                                      context,
                                                      BookIndividualView.id,
                                                      arguments: BookIdandAuth(
                                                        booksForYou[itemIndex]
                                                            .id,
                                                        ftoken,
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Card(
                                                          elevation: 3,
                                                          child: Container(
                                                            height: 140,
                                                            width: 100,
                                                            child: ClipRRect(
                                                              child:
                                                                  Image.network(
                                                                booksForYou[
                                                                        itemIndex]
                                                                    .imgUrl,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                              booksForYou[
                                                                      itemIndex]
                                                                  .bookTitle,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            booksForYou[
                                                                    itemIndex]
                                                                .author,
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                        }),
                                  )
                                : Homepage_Cat[index] == "Featured"
                                    ? Container(
                                        height: 210,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: featured.length + 1,
                                            itemBuilder: (context, itemIndex) {
                                              return itemIndex >
                                                      featured.length - 1
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              //GOTO VIEW ALL PAGE
                                                              //GOTO VIEW ALL PAGE
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                SeeAll.id,
                                                                arguments:
                                                                    ftoken,
                                                              );
                                                            },
                                                            child: Column(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .amberAccent,
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove_red_eye_rounded,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  radius: 35,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      "See all"),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        )
                                                      ],
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        //goto book info page
                                                        Navigator.pushNamed(
                                                            context,
                                                            BookIndividualView
                                                                .id);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Card(
                                                              elevation: 3,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              child: Container(
                                                                height: 140,
                                                                width: 100,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16),
                                                                  child: Image
                                                                      .network(
                                                                    featured[
                                                                            itemIndex]
                                                                        .imgUrl,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 100,
                                                              child: Center(
                                                                child: RichText(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  strutStyle:
                                                                      StrutStyle(
                                                                          fontSize:
                                                                              16.0),
                                                                  text:
                                                                      TextSpan(
                                                                    text: featured[
                                                                            itemIndex]
                                                                        .bookTitle,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 100,
                                                              child: Center(
                                                                child: RichText(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  strutStyle:
                                                                      StrutStyle(
                                                                          fontSize:
                                                                              14.0),
                                                                  text:
                                                                      TextSpan(
                                                                    text: featured[
                                                                            itemIndex]
                                                                        .author,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontFamily:
                                                                            "LeelawUI"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                            }),
                                      )
                                    : Homepage_Cat[index] == "Latest Books"
                                        ? Container(
                                            height: 210,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    latestbooks.length + 1,
                                                itemBuilder:
                                                    (context, itemIndex) {
                                                  return itemIndex >
                                                          latestbooks.length - 1
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  //GOTO VIEW ALL PAGE
                                                                  //GOTO VIEW ALL PAGE
                                                                  Navigator
                                                                      .pushNamed(
                                                                    context,
                                                                    SeeAll.id,
                                                                    arguments:
                                                                        ftoken,
                                                                  );
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .amberAccent,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove_red_eye_rounded,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      radius:
                                                                          35,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          "See all"),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            )
                                                          ],
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            //goto book info page
                                                            Navigator.pushNamed(
                                                                context,
                                                                BookIndividualView
                                                                    .id);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Card(
                                                                  elevation: 3,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height: 140,
                                                                    width: 100,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                      child: Image
                                                                          .network(
                                                                        latestbooks[itemIndex]
                                                                            .imgUrl,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Center(
                                                                    child:
                                                                        RichText(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      strutStyle:
                                                                          StrutStyle(
                                                                              fontSize: 16.0),
                                                                      text:
                                                                          TextSpan(
                                                                        text: latestbooks[itemIndex]
                                                                            .bookTitle,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black87,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Center(
                                                                    child:
                                                                        RichText(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      strutStyle:
                                                                          StrutStyle(
                                                                              fontSize: 14.0),
                                                                      text:
                                                                          TextSpan(
                                                                        text: /* latestbooks[itemIndex]
                                                                            .author, */
                                                                            'abc',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontFamily: "LeelawUI"),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                }),
                                          )
                                        : Container(
                                            height: 210,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: BestRated.length + 1,
                                                itemBuilder:
                                                    (context, itemIndex) {
                                                  return itemIndex >
                                                          BestRated.length - 1
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  //GOTO VIEW ALL PAGE
                                                                  //GOTO VIEW ALL PAGE
                                                                  Navigator
                                                                      .pushNamed(
                                                                    context,
                                                                    SeeAll.id,
                                                                    arguments:
                                                                        ftoken,
                                                                  );
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .amberAccent,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove_red_eye_rounded,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      radius:
                                                                          35,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          "See all"),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            )
                                                          ],
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            //goto book info page
                                                            Navigator.pushNamed(
                                                                context,
                                                                BookIndividualView
                                                                    .id);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Card(
                                                                  elevation: 3,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height: 140,
                                                                    width: 100,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                      child: Image
                                                                          .network(
                                                                        BestRated[itemIndex]
                                                                            .imgUrl,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Center(
                                                                    child:
                                                                        RichText(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      strutStyle:
                                                                          StrutStyle(
                                                                              fontSize: 16.0),
                                                                      text:
                                                                          TextSpan(
                                                                        text: BestRated[itemIndex]
                                                                            .bookTitle,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black87,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Center(
                                                                    child:
                                                                        RichText(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      strutStyle:
                                                                          StrutStyle(
                                                                              fontSize: 14.0),
                                                                      text:
                                                                          TextSpan(
                                                                        text: BestRated[itemIndex]
                                                                            .author,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontFamily: "LeelawUI"),
                                                                      ),
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
            )),
      );
  }

  void Category_items() async {
    try {
      await _firestore
          .collection("Book_Collection")
          .where("OwnerUID",
              isNotEqualTo: FirebaseAuth.instance.currentUser.uid)
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
          double quotedPrice = i.get("QuotedDeposit");
          String coll_type = i.get("Homepage_category");
          String original_loc = i.id.toString().trim();
          String owneruid = i.get("OwnerUID");
          String selleraddress = i.get("seller_address");
          String sellerphn = i.get("seller_phoneNumber");
          bool availability = i.get("Availability");
          String sellerFullname = i.get("SellerFullName");
          String sellerUPI = i.get("seller_UPI");
          List homepage_tag_cat = i.get("tags");
          List GenreTags = [""];
          try {
            GenreTags = i.get("Genretags");
          } catch (e) {
            print(e);
          }
          TotalBookName.add(bkname);
          TotalBookCollID.add(i.id);
          if (homepage_tag_cat.contains("booksforyou")) {
            booksForYou.add(homepage_items_featured());
          }
          if (homepage_tag_cat.contains("featured")) {
            featured.add(homepage_items_featured());
          }
         
          if (homepage_tag_cat.contains("best rated")) {
            BestRated.add(homepage_items_featured());
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

class BookIdandAuth {
  final int bookID;
  final String bookAuth;

  BookIdandAuth(this.bookID, this.bookAuth);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  // Use this method to automatically convert the push data, in case you gonna use our data standard
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
