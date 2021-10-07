import 'package:flutter/material.dart';

class ReturnBooks extends StatefulWidget {
  static String id = 'ReturnBooks';

  @override
  _ReturnBooksState createState() => _ReturnBooksState();
}

class _ReturnBooksState extends State<ReturnBooks> {
  final List<String> _books = ['Book1', 'Book2', 'Book3'];
  final List<String> _returnBooksCover = [
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBD06),
        title: Text('Return Books'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _books.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  width: 85.0,
                  height: 75.0,
                  child: Image.network(
                    _returnBooksCover[index],
                    width: 75.00,
                    height: 75.00,
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_books[index]),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.black),
                      ),
                      onPressed: () {
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              'This action is not reversible.Do you wish to continue?',
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {},
                                child: Text(
                                  'Cancel',
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Color(0xFFE5E5E5),
                                height: 50.00,
                                minWidth: 100.00,
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              MaterialButton(
                                onPressed: () {},
                                child: Text('Yes'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Color(0xFFFFBD06),
                                height: 50.00,
                                minWidth: 100.00,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        width: 100.00,
                        height: 25.00,
                        child: Text(
                          'initiate return',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
