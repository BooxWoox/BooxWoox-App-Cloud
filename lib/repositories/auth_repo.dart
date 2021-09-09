import 'dart:convert';

import 'package:bookollab/Models/Api/auth.dart';
import 'package:bookollab/Models/Api/exceptions.dart';
import 'package:bookollab/repositories/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'endpoints.dart';

class AuthRepository {
  Api _client = new Api();
  String token;

  Future<void> sendOtpToPhone(String phone) async {
    var res = await _client.post(
      baseurl + ksendOtp,
      {'phone': phone},
    );
    var response = SendOtpResponse.fromJson(res);
    token = response.token;
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      var res = await _client.post(
        baseurl + kverifyOtp,
        {'otp': otp},
        headers: {'token': token},
      );
      VerifyOtpResponse response = VerifyOtpResponse.fromJson(res);
      token = response.token;
      return true;
    } catch (e) {
      if (e is BadRequestException) {
        return false;
      } else {
        throw e;
      }
    }
  }
}

final authProvider = Provider((ref) => AuthRepository());
