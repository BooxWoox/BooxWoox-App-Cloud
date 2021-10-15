import 'package:http/http.dart' as http;
import 'dart:convert';
import 'genreList.dart';

class GenreAPI{
  static Future<GenreList> genrelistapi(String authToken) async{
    var url = 'https://hu7cb5n3g3.execute-api.ap-south-1.amazonaws.com/Prod/FilterByGenre';

    var response = await http.post(Uri.parse(url), headers: {'authToken': authToken});

    var gList = GenreList.fromJson(json.decode(response.body));

    return gList;
  }
}
