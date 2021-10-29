import 'dart:convert';

import 'package:bookollab/Models/book.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';


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
    if (response.statusCode >= 300) {
      throw Exception(jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    List<dynamic> temp = jsonDecode(response.body);
    return temp.map((e) => BookShort.fromJson(e)).toList();
  }

  static Future<BookDetails> getBookDetailed(String token, int id) async {
    var response = await http.post(
      Uri.parse(
        'https://f672mr05b0.execute-api.ap-south-1.amazonaws.com/Prod/sarthak_test/get_bookDetails',
      ),
      headers: {
        "authToken": token,
      },
      body: jsonEncode({"id": id}),
    );
    if (response.statusCode >= 300) {
      throw Exception(jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    return BookDetails.fromJson(jsonDecode(response.body));
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
    if (response.statusCode >= 300) {
      throw Exception(jsonDecode(response.body)['message'] ?? "Unexpected error");
    }

    return response;
  }

  static Future<List<homepage_items_featured>> HomeBooks(String token, List genre) async {
    var response = await http.post(
      Uri.parse(
        'https://bxfw75ftq2.execute-api.ap-south-1.amazonaws.com/Prod/homeScreen',
      ),
      headers: {
        "authToken": token,
      },
      body: jsonEncode({"genrelist": genre}),
    );
    if (response.statusCode >= 300) {
      throw Exception(jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    List<dynamic> bookdata = jsonDecode(response.body);
    return bookdata.map((e) => homepage_items_featured.fromJson(e)).toList();
  }

}


 

