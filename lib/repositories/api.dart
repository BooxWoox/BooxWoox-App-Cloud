import 'package:bookollab/repositories/endpoints.dart';
import 'package:dio/dio.dart';

class _Api {
  Dio client;
  _Api() {
    BaseOptions config = BaseOptions(baseUrl: baseurl);
    client = new Dio(config);
  }
}

Dio client = new _Api().client;
