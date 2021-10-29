class SendOtpRequest {
  String phone;
}

class SendOtpResponse {
  String messageId;
  String token;

  SendOtpResponse({this.messageId, this.token});

  SendOtpResponse.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    token = json['token'];
  }
}

class VerifyOtpRequest {
  String token;
  String otp;
}

class VerifyOtpResponse {
  String message;
  String token;

  VerifyOtpResponse({this.message, this.token});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['authToken'];
  }
}
