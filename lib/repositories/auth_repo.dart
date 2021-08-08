import 'package:bookollab/Models/Api/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'endpoints.dart';
import 'api.dart';

class AuthRepository {
  String token;

  void sendOtpToPhone(String phone) async {
    var response = SendOtpResponse.fromJson(
        (await client.post(ksendOtp, data: {'phone': phone})).data);
    token = response.token;
  }

  void verifyOtp(String otp) async {
    var res = await client.post(kverifyOtp, data: {'otp': otp});
    var response = VerifyOtpResponse.fromJson(res.data);
    token = response.token;
    if (response.message != "success") {
      throw Error();
    }
  }
}

final authProvider = StateProvider((ref) => AuthRepository());
