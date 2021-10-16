import 'dart:convert';

import 'package:bookollab/Models/book.dart';

import 'package:http/http.dart' as http;

class BooksRepository {
  static Future<List<BookShort>> getAllBooks(String token, int page) async {
    var response = await http.post(
      Uri.parse(
        'https://in8hwpowl2.execute-api.ap-south-1.amazonaws.com/Prod/sarthak_test/get_bookPagination',
      ),
      headers: {
        "authToken": token,
      },
      body: jsonEncode({"page": page}),
    );
    List<dynamic> temp = jsonDecode(response.body);
    return temp.map((e) => BookShort.fromJson(e)).toList();
  }

  static Future<BookDetailed> getBookDetailed(String token, int id) async {
    var response = await http.post(
      Uri.parse(
        'https://f672mr05b0.execute-api.ap-south-1.amazonaws.com/Prod/sarthak_test/get_bookDetails',
      ),
      headers: {
        "authToken": token,
      },
      body: jsonEncode({"id": id}),
    );
    return BookDetailed.fromJson(jsonDecode(response.body));
  }

  static Future addBook(String token, AddBook addBook) async {
    var response = await http.post(
      Uri.parse(
        'https://gxq9227rxh.execute-api.ap-south-1.amazonaws.com/Prod/addBooks',
      ),
      headers: {
        "authToken": token,
      },
      body: jsonEncode(
        addBook.toJson(),
      ),
    );

    return response;
  }
}
