import 'dart:convert';
import 'dart:io';

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
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
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
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
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
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
    }

    return response;
  }

  static Future<List<homepage_items_featured>> HomeBooks(
      String token, List genre) async {
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
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    List<dynamic> bookdata = jsonDecode(response.body);
    return bookdata.map((e) => homepage_items_featured.fromJson(e)).toList();
  }

  static Future<UserDetails> GetUserDetails(String token) async {
    var response = await http.get(
        Uri.parse(
          'https://pru4gl0p4k.execute-api.ap-south-1.amazonaws.com/Prod/get/profile',
        ),
        headers: {
          "authToken": token,
        });
    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    return UserDetails.fromJson(jsonDecode(response.body));
  }

  static Future<List<LatestBooks>> GetLatestBooks(
      String token, String count) async {
    var response = await http.post(
        Uri.parse(
          'https://bxfw75ftq2.execute-api.ap-south-1.amazonaws.com/Prod/homeScreen',
        ),
        headers: {
          "authToken": token,
        },
        body: jsonEncode({
          "count": count,
        }));
    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    List<dynamic> bookdata = jsonDecode(response.body);
    return bookdata.map((e) => LatestBooks.fromJson(e)).toList();
  }

  static Future<ImageData> GetImage(
      String token, String folder, String file) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://biixth2lcl.execute-api.ap-south-1.amazonaws.com/Prod/upload/image'));

    request.files.add(await http.MultipartFile.fromPath("file", file));
    request.headers.addAll({
      "authtoken": token,
      "foldername": folder,
    });
    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(responseString)['message'] ?? "Unexpected error");
    }

    return ImageData.fromJson(jsonDecode(responseString));
  }

  static Future<String> UpdateProfile(String token, String firstName,
      String lastName, String emailId, String imageurl) async {
    var response = await http.post(
      Uri.parse(
          'https://dfeofi86hg.execute-api.ap-south-1.amazonaws.com/Prod/update/profile'),
      headers: {
        "authToken": token,
      },
      body: {
        "firstname": firstName,
        "lastname": lastName,
        "emailid": emailId,
        "img": imageurl,
      },
    );
    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    return response.body;
  }

  static Future<String> VerifyOrder(
      String orderId, String paymentId, String signature, String token) async {
    var response = await http.post(
        Uri.parse(
            'https://49i1h45sfb.execute-api.ap-south-1.amazonaws.com/Prod/verifyorder'),
        headers: {
          "authToken": token,
        },
        body: {
          "razorpay_order_id": orderId,
          "razorpay_payment_id": paymentId,
          "razorpay_signature": signature,
        });
    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    return response.body;
  }
}
