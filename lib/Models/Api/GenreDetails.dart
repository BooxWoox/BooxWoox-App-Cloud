
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenreDetails {
  static Future<List<String>> AllGenrename(String token) async {
    var url =
        "https://1uz3wnfddj.execute-api.ap-south-1.amazonaws.com/Prod/getAllGenre";
    var response =
        await http.post(Uri.parse(url), headers: {'authToken': token});
    print(json.decode(response.body).runtimeType);
    var temp = json.decode(response.body) as List<dynamic>;
    var genres = <String>[];
    temp.forEach((element) {
      genres.add(element.toString());
    });
    return genres;
  }
}
