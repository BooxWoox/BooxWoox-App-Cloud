import 'package:http/http.dart' as http;
import 'dart:convert';
import 'genreList.dart';

class GenreAPI{
  static Future<GenreList> genrelistapi() async{
    var url = 'https://hu7cb5n3g3.execute-api.ap-south-1.amazonaws.com/Prod/FilterByGenre';

    var response = await http.get(Uri.parse(url));

    var returnList = GenreList.fromJson(json.decode(response.body));

    return returnList;
  }
}
