import 'dart:convert';

import 'package:bookollab/Api/exceptions.dart';
import 'package:bookollab/Models/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class ApiProvider extends StateNotifier<String> {
  ApiProvider() : super(null);

  String otpToken;

  String get token => state;
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
    state = token;
  }

  Future<void> sendOtpToPhone(String phone) async {
    var res = await post(
      Uri.parse(
          'https://ajs2lbc197.execute-api.ap-south-1.amazonaws.com/Prod/sendotp'),
      body: jsonEncode({'phoneno': phone}),
    );
    handleError(res);
    var response = SendOtpResponse.fromJson(jsonDecode(res.body));
    otpToken = response.token;
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      var res = await post(
        Uri.parse(
            'https://z88f4npptf.execute-api.ap-south-1.amazonaws.com/Prod/validateotp'),
        body: jsonEncode({'otp': otp}),
        headers: {'authToken': token},
      );
      VerifyOtpResponse response =
          VerifyOtpResponse.fromJson(jsonDecode(res.body));
      state = response.token;
      handleError(res);
    } catch (e) {
      if (e is BadRequestException) {
        return false;
      } else {
        throw e;
      }
    }
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

final apiProvider = StateNotifierProvider.autoDispose<ApiProvider, String>(
    (ref) => ApiProvider());

final allGenres = FutureProvider.autoDispose((ref) async {
  var token = ref.watch(apiProvider);
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
});
