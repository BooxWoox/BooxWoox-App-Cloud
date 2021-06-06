import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/UI/Book_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pagination/pagination.dart';
import 'package:paginate_firestore/paginate_firestore.dart';


final _firestore = FirebaseFirestore.instance;

class AllBooksPage extends StatefulWidget {
  const AllBooksPage({Key key}) : super(key: key);
  static String id = 'all_books_page';

  @override
  _AllBooksPageState createState() => _AllBooksPageState();
}

class _AllBooksPageState extends State<AllBooksPage> {
  // Quoted parameters from Admin params
  double _quotedrentpercent=10 ;//default value

  @override
  void initState() {
    admin_params_get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child:PaginateFirestore(
                itemBuilderType: PaginateBuilderType.listView, // listview and gridview
                itemBuilder: (index, context, snapshot) {
                  return InkWell(
                    onTap: () {
                      //Changes needed
                      // maindisp_book_info_model(homepage_items_featured(
                      //     snapshot.get("Author"),
                      //     snapshot.get("BookName"),
                      //     snapshot.get("Homepage_category"),
                      //     snapshot.get("ImageUrl"),
                      //     snapshot.get("Likes"),
                      //     snapshot.get("Dislikes"),
                      //     snapshot.get("MRP"),
                      //     snapshot.get("QuotedDeposit"),
                      //     snapshot.id.toString().trim(),
                      //     snapshot.get("OwnerUID"),
                      //     snapshot.get("seller_address"),
                      //     snapshot.get("seller_phoneNumber"),
                      //     snapshot.get("Availability"),
                      //     snapshot.get("SellerFullName"),
                      //     snapshot.get("seller_UPI")));
                      //

                      Navigator.pushNamed(context, Book_info.id,
                          arguments: maindisp_book_info_model(homepage_items_featured(
                              snapshot.get("Author"),
                              snapshot.get("BookName"),
                              snapshot.get("Homepage_category"),
                              snapshot.get("ImageUrl"),
                              snapshot.get("Likes"),
                              snapshot.get("Dislikes"),
                              snapshot.get("MRP"),
                              snapshot.get("QuotedDeposit"),
                              snapshot.id.toString().trim(),
                              snapshot.get("OwnerUID"),
                              snapshot.get("seller_address"),
                              snapshot.get("seller_phoneNumber"),
                              snapshot.get("Availability"),
                              snapshot.get("SellerFullName"),
                              snapshot.get("seller_UPI"))));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      margin: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16)),
                              child: Image.network(
                                snapshot.data()['ImageUrl'],
                                fit: BoxFit.cover,

                                width: 100,
                                filterQuality: FilterQuality.low,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8)),
                              child: Text(
                                ' ${snapshot.data()['Homepage_category']} ',
                                style: TextStyle(
                                  backgroundColor: Color(0xFFFFCC00),
                                ),
                              ),
                            )
                          ]),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:MediaQuery.of(context).size.width/1.8,
                                child: Text(
                                  snapshot.data()['BookName'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "LeelawUI",
                                  ),
                                ),
                              ),
                              Container(
                                width:MediaQuery.of(context).size.width/1.8,
                                child: Text(
                                  snapshot.data()['Author'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontFamily: "LeelawUI",
                                  ),
                                ),
                              ),
                              // if ((allBooks[index].item.Likes +
                              //     allBooks[index].item.Dislikes) !=
                              //     0)
                                // Row(
                                //   children: [
                                //     RatingBarIndicator(
                                //       rating: (5 *
                                //           allBooks[index].item.Likes /
                                //           (allBooks[index].item.Likes +
                                //               allBooks[index].item.Dislikes)),
                                //       // rating: 2.5,
                                //       itemBuilder: (context, index) => Icon(
                                //         Icons.star,
                                //         color: Colors.amber,
                                //       ),
                                //       itemCount: 5,
                                //       itemSize: 24.0,
                                //       direction: Axis.horizontal,
                                //     ),
                                //     Text(
                                //       (allBooks[index].item.Likes +
                                //           allBooks[index].item.Dislikes)
                                //           .toString(),
                                //       style: TextStyle(
                                //           fontFamily: "LeelawUI",
                                //           color: Colors.grey),
                                //     )
                                //   ],
                                // ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\u{20B9}${(snapshot.data()['QuotedDeposit'] *_quotedrentpercent/100).toStringAsFixed(2)}/month',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "LeelawUI",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '\u{20B9}${(snapshot.data()['MRP']).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 16,
                                        fontFamily: "LeelawUI",
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                child: snapshot.data()['Availability']
                                    ? Text(
                                  ' AVAILABLE ',
                                  style: TextStyle(
                                      backgroundColor: Colors.green,
                                      color: Colors.white,
                                      fontFamily: "LeelawUI"),
                                )
                                    : Text(
                                  ' OUT OF STOCK ',
                                  style: TextStyle(
                                      backgroundColor: Colors.redAccent,
                                      color: Colors.white,
                                      fontFamily: "LeelawUI"),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  },
                // orderBy is compulsary to enable pagination
                query: _firestore
                    .collection("Book_Collection")
                    .where("adminapproval", isEqualTo: 1)
                    .orderBy('Availability',descending: true),
                isLive: true // to fetch real-time data
            ),
          ),
        ],
      ),
    );
  }
  Future admin_params_get() async {
    try {
      await _firestore
          .collection("Admin")
          .doc("Quoted_Parameters")
          .get()
          .then((value) {
        _quotedrentpercent =
            double.parse(value["Quoted_Rent_Percent"].toString());
        setState(() {
        });
        return true;
      });
    } catch (e) {
      print(e.message);
    }
    return false;
  }
}
