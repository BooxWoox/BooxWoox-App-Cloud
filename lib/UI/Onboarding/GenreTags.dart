import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenreTagsPage extends StatefulWidget {
  const GenreTagsPage({Key key}) : super(key: key);

  static const String id = "GenreTags_Page";

  @override
  _GenreTagsPageState createState() => _GenreTagsPageState();
}

class _GenreTagsPageState extends State<GenreTagsPage> {
  List<GenreTag> _generateGenreTags() {
    return [GenreTag(genre: 'adventure')];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "UIAssets/genre/book.svg",
                    width: 125,
                  ),
                  Expanded(
                    child: Text(
                      "What are your favourite genres",
                      style: TextStyle(
                        fontFamily: 'Avenir95Black',
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                "(Choose atleast 3)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.horizontal,
                children: _generateGenreTags(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenreTag extends StatelessWidget {
  final String genre;
  const GenreTag({Key key, @required this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 125,
      child: Stack(
        children: [
          Image.asset(
            "UIAssets/genre/$genre.png",
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.8)),
            child: Text(genre),
          ),
        ],
      ),
    );
  }
}
