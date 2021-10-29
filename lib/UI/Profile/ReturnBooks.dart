import 'package:bookollab/UI/Book_info.dart';
import 'package:flutter/material.dart';

class ReturnBooks extends StatefulWidget {
  static String id = 'ReturnBooks';

  @override
  _ReturnBooksState createState() => _ReturnBooksState();
}

class _ReturnBooksState extends State<ReturnBooks> {
  final List<String> _books = ['Prescient - D.S. Murphy', 'Prescient - D.S. Murphy', 'Book3','Book4','Book5','Book6','Book7','Book8','Book9'];
  final List<String> _returnBooksCover = [
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBD06),
        title: Text(
          'Return Books',
          // textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _books.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(17.0)
                  ),
                  child: Container(
                    child: Image.network(_returnBooksCover[index]),
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0,12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(_books[index]),
                      Text(
                        _books[index],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                'This action is not reversible. Do you wish to continue?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0,8.0),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    color: Color(0xFFE5E5E5),
                                    height: 40.00,
                                    minWidth: 120.00,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 15.0,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0,8.0),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Color(0xFFFFBD06),
                                    height: 40.00,
                                    minWidth: 120.00,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 20.0,
                                // ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: 25.0,
                          width: 100.0,
                          margin: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                          decoration: BoxDecoration(
                            color: Color(0xffFFBD06),
                            border: Border.all(
                              color: Color(0xff000000),
                            ),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Center(
                            child: Text(
                              'Initiate Return',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  // Navigator.pushNamed(context, Book_info.id);
                },
              );
            }),
      ),
    );
  }
}
