import 'package:bookollab/Models/Api/books.dart';
import 'package:bookollab/Models/book.dart';
import 'package:bookollab/State/auth.dart';
import 'package:bookollab/UI/widgets/ThemeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// void main() {
//   runApp(Book_individual_view());
// }

class BookIndividualView extends StatefulWidget {
  final BookShort book;

  const BookIndividualView({Key key, @required this.book}) : super(key: key);

  @override
  _BookIndividualViewState createState() => _BookIndividualViewState();
}

class _BookIndividualViewState extends State<BookIndividualView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFBD06),
        elevation: 0,
      ),
      body: Consumer(builder: (context, watch, child) {
        final token = watch(apiProvider);
        return FutureBuilder<BookDetailed>(
            future: BooksRepository.getBookDetailed(token, widget.book.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (!snapshot.hasData) {
                return LinearProgressIndicator();
              } else {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Stackssss(widget.book, snapshot.data),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Box(
                            height: 115,
                            child: Container(
                              // margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tags',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    child: Wrap(
                                      children: snapshot.data.tags
                                          .split(" ")
                                          .map((e) => Tag(name: e))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Box(
                            height: 131,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                              padding: EdgeInsets.only(left: 10.0),
                              // alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Highlights',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          ),
                          Box(
                            height: 131.0,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                              padding: EdgeInsets.only(left: 10.0),
                              // alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          ),
                          Box(
                            height: 348.0,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                              padding: EdgeInsets.only(left: 10.0),
                              // alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ));
              }
            });
      }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 83.0,
          // width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: Color(0xffE5E5E5),
                offset: Offset(0, -8), //(x,y)
                blurRadius: 33,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ThemeTextButton(label: 'Add to wishlist', onPressed: () {})
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ThemeButton(label: 'Borrow Now', onPressed: () {})
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Stackssss extends StatelessWidget {
  final BookShort book;
  final BookDetailed bookDetailed;

  const Stackssss(this.book, this.bookDetailed, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 175.0,
          decoration: BoxDecoration(
            color: Color(0xffFFBD06),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 175.0, 0.0, 0.0),
          child: Container(
            // height: 340.0,
            decoration: BoxDecoration(
              color: Color(0xffFFBD06),
            ),
            child: Container(
              // height: 340.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Container(
                      height: 120.0,
                    ),
                    Text(
                      book.bookTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 27.0,
                      ),
                    ),
                    Text(
                      'Owner name',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'Rs. ${bookDetailed.mrp}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 27.0,
                          ),
                        ),
                        // Text(
                        //   '/month',
                        // ),
                        // SizedBox(
                        //   width: 100.0,
                        // ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Icon(
                        //       Icons.star,
                        //       color: Color(0xffFFBD06),
                        //     ),
                        //     Text(
                        //       '4/5',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    // Text(
                    //   'Deposit - Rs. 90.00',
                    // ),
                    Wrap(
                      children: bookDetailed.conditionBook
                          .split(" ")
                          .map(
                            (e) => Chip(
                              label: Text(e),
                              backgroundColor: Color(0xFF0094FF),
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 30.0,
          left: MediaQuery.of(context).size.width * 0.25,
          child: Container(
            height: 250.0,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x66000000),
                    offset: Offset(0, 5), //(x,y)
                    blurRadius: 20.0,
                    spreadRadius: 1,
                  )
                ]),
            child: Image.network(
              'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
            ),
          ),
        ),
      ],
    );
  }
}

class Box extends StatelessWidget {
  Box({@required this.child, @required this.height});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      // height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: Color(0xffE5E5E5),
            offset: Offset(0, 4), //(x,y)
            blurRadius: 22,
            spreadRadius: 7,
          )
        ],
      ),
      child: child,
    );
  }
}

class Tag extends StatelessWidget {
  Tag({@required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      decoration: BoxDecoration(
        color: Color(0xffFFBD06),
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 35.0,
      width: 90.0,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
