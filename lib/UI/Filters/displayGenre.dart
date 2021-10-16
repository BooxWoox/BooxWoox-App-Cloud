import 'package:bookollab/UI/Filters/genreList.dart';
import 'package:flutter/material.dart';

class DisplayGenre extends StatefulWidget {

  static String id = 'display_genre';

  final List<FilterByGenreResponse> books;

  const DisplayGenre(this.books, {Key key,}) : super(key: key);

  @override
  _DisplayGenreState createState() => _DisplayGenreState();
}

class _DisplayGenreState extends State<DisplayGenre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFCC00),
        title: Text('Result', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => Text(widget.books[index].bookTitle),
        itemCount: widget.books.length,
      ),
    );
  }
}