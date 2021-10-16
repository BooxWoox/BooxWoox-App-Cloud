import 'dart:convert';
import 'package:bookollab/Api/exceptions.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> req, {Map<String, dynamic> headers}) async {
    var rawres = await http.post(Uri.parse(url), body: req);
    final res = jsonDecode(rawres.body);
    if (rawres.statusCode < 200 || rawres.statusCode >= 300) {
      throw ApiException.fromError(res["message"] ?? "Error", rawres.statusCode);
    }
    return res;
  }
}
