import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import 'genreList.dart';

class GenreAPI{
  static Future<List<FilterByGenreResponse>> filterByGenreListApi(String authToken, List<String> genres) async{
    var url = 'https://hu7cb5n3g3.execute-api.ap-south-1.amazonaws.com/Prod/FilterByGenre';

    var response = await http.post(Uri.parse(url), headers: {'authToken': authToken,}, body: jsonEncode({'genre': genres.toString()}));


    Logger().i(response);
    if(response.statusCode == 404 || response.statusCode == 400)
    {
      return [];
    }

    List<dynamic> bookList = json.decode(response.body);

    return bookList.map((e) => FilterByGenreResponse.fromJson(e)).toList();
  }
}
