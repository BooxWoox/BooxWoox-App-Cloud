import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:bookollab/UI/Book_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final _firestore = FirebaseFirestore.instance;

class AllBooksPage extends StatefulWidget {
  const AllBooksPage({Key key}) : super(key: key);
  static String id = 'all_books_page';

  @override
  _AllBooksPageState createState() => _AllBooksPageState();
}

class _AllBooksPageState extends State<AllBooksPage> {
  List<maindisp_book_info_model> allBooks = [];
  // Quoted parameters
  double _quotedrentpercent=10 ;

  void getAllBooks() async {
    try {
      await _firestore
          .collection("Book_Collection")
          .where("adminapproval", isEqualTo: 1)
          .get()
          .then((value) {
        for (var i in value.docs) {
          double mrp=i.get("MRP");
          double quotedPrice=i.get("QuotedDeposit");
          allBooks.add(maindisp_book_info_model(homepage_items_featured(
              i.get("Author"),
              i.get("BookName"),
              i.get("Homepage_category"),
              i.get("ImageUrl"),
              i.get("Likes"),
              i.get("Dislikes"),
              mrp,
              quotedPrice,
              i.id.toString().trim(),
              i.get("OwnerUID"),
              i.get("seller_address"),
              i.get("seller_phoneNumber"),
              i.get("Availability"),
              i.get("SellerFullName"))));
        }
        setState(() {
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    admin_params_get();
    getAllBooks();
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
            child: ListView.builder(
                itemCount: allBooks.length,
                itemBuilder: (context, index) {
                  //add card here
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Book_info.id,
                          arguments: allBooks[index]);
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
                                allBooks[index].item.ImageURl,
                                fit: BoxFit.cover,
                                width: 100,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8)),
                              child: Text(
                                ' ${allBooks[index].item.Collection_type} ',
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
                                  allBooks[index].item.BookName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "LeelawUI",
                                  ),
                                ),
                              ),
                              Text(
                                allBooks[index].item.Author,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "LeelawUI",
                                    color: Colors.grey),
                              ),
                              if ((allBooks[index].item.Likes +
                                      allBooks[index].item.Dislikes) !=
                                  0)
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: (5 *
                                          allBooks[index].item.Likes /
                                          (allBooks[index].item.Likes +
                                              allBooks[index].item.Dislikes)),
                                      // rating: 2.5,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 24.0,
                                      direction: Axis.horizontal,
                                    ),
                                    Text(
                                      (allBooks[index].item.Likes +
                                              allBooks[index].item.Dislikes)
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: "LeelawUI",
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\u{20B9}${(allBooks[index].item.QuotedPrice *_quotedrentpercent/100).toStringAsFixed(2)}/month',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "LeelawUI",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '\u{20B9}${(allBooks[index].item.Mrp).toStringAsFixed(2)}',
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
                                child: allBooks[index].item.availability
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
                }),
          )
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
      print("yohooooooooooooooooo2" + e);
    }
    return false;
  }
}
