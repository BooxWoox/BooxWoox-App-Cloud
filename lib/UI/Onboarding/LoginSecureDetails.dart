import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginSecureDetails{
  static final _storage = FlutterSecureStorage();

  static const _keyUserPhoneNumber = 'default';
  static const _keyUserAccessToken = 'abcd';
  

  static Future setPhoneNumber(String userPhoneNumber) async =>
    await _storage.write(key: _keyUserPhoneNumber, value: userPhoneNumber);  
  
  static Future<String> getPhoneNumber() async =>
    await _storage.read(key: _keyUserPhoneNumber);
  

  static Future setAccessToken(String accessToken) async =>
    await _storage.write(key: _keyUserAccessToken, value: accessToken);

  static Future<String> getAccessToken() async => 
    await _storage.read(key: _keyUserAccessToken);  

  static logout() async => 
    await _storage.deleteAll();
}