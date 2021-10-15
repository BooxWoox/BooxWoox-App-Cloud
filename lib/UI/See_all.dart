import 'package:bookollab/UI/Book_info.dart';
import 'package:flutter/material.dart';

class SeeAllBooks extends StatefulWidget {

  static String id = 'Seeallbooks';

  @override
  _SeeAllBooksState createState() => _SeeAllBooksState();
}

class _SeeAllBooksState extends State<SeeAllBooks> {

  final List<String> _seeallbooks = ['Prescient - D.S. Murphy', 'Prescient - D.S. Murphy', 'Book3','Book4','Book5','Book6','Book7','Book8','Book9','Books10'];
  final List<String> _seeallBooksCover = [
    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.tune,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            // crossAxisSpacing: 10.0,
            // mainAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Book_info.id);
              },
              child: Container(

                color: Colors.white,
                margin: EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Image.network(
                            _seeallBooksCover[index],
                            // width: 200.0,
                            // height: 100.0,
                          ),
                          // height: 100.0,
                          // width: 200.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              _seeallbooks[index],
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
