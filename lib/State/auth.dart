import 'dart:convert';

import 'package:bookollab/Api/exceptions.dart';
import 'package:bookollab/Models/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiProvider {
  
  String otpToken;

  String token;
  devLogin() async {
    var response = await post(
      Uri.parse(
        'https://rv99eekftl.execute-api.ap-south-1.amazonaws.com/Prod/user/login',
      ),
      body: jsonEncode(
        {
          "username": "rupakbiswas2304@gmail.com",
          "password": "1234",
        },
      ),
    );
    handleError(response);
    String token = jsonDecode(response.body)['authToken'];
    this.token = token;
  }

  Future<void> sendOtpToPhone(String phone) async {
    var res = await post(
      Uri.parse(
          'https://ajs2lbc197.execute-api.ap-south-1.amazonaws.com/Prod/sendotp'),
      body: jsonEncode({'phoneno': phone}),
    );
    handleError(res);

    Logger().d(res.body);
    var response = SendOtpResponse.fromJson(jsonDecode(res.body));
    otpToken = response.token;
  }

  Future<bool> verifyOtp(String otp) async {
    // try {
      var res = await post(
        Uri.parse(
            'https://z88f4npptf.execute-api.ap-south-1.amazonaws.com/Prod/validateotp'),
        body: jsonEncode({'otp': otp}),
        headers: {'authToken': otpToken},
      );
      handleError(res);
      Logger().d(res.body);
      VerifyOtpResponse response =
          VerifyOtpResponse.fromJson(jsonDecode(res.body));
      token = response.token;
      Logger().d("State has been set to $token");
    // } catch (e) {
    //   if (e is BadRequestException) {
    //     return false;
    //   } else {
    //     throw e;
    //   }
    // }
  }

  Future<List<String>> getAllGenres() async {
    var url =
        "https://1uz3wnfddj.execute-api.ap-south-1.amazonaws.com/Prod/getAllGenre";
    var response = await post(Uri.parse(url), headers: {'authToken': token});
    print(json.decode(response.body).runtimeType);
    var temp = json.decode(response.body) as List<dynamic>;
    var genres = <String>[];
    temp.forEach((element) {
      genres.add(element.toString());
    });
    return genres;
  }

  handleError(Response response) {
    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error occurred");
    }
  }
}

final apiProvider = Provider<ApiProvider>(
    (ref) => ApiProvider());

final allGenres = FutureProvider((ref) async {
  Logger().d("genres refresh");
  var apiprovider = ref.watch(apiProvider);
  var url =
      "https://1uz3wnfddj.execute-api.ap-south-1.amazonaws.com/Prod/getAllGenre";
  var response = await post(Uri.parse(url), headers: {'authToken': apiprovider.token});
  print(json.decode(response.body).runtimeType);
  var temp = json.decode(response.body) as List<dynamic>;
  var genres = <String>[];
  temp.forEach((element) {
    genres.add(element.toString());
  });
  return genres;
});
