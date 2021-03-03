import 'package:flutter/cupertino.dart';

class homepage_items_featured{
  String _Author;
  String _BookName;
  String _Collection_type;
  String _ImageURl;

  set Author(String value) {
    _Author = value;
  }

  homepage_items_featured(this._Author, this._BookName,
      this._Collection_type, this._ImageURl, this._BookCollectionidentity);

  String _BookCollectionidentity;

  String get Author => _Author;

  String get BookName => _BookName;

  String get Collection_type => _Collection_type;

  String get ImageURl => _ImageURl;

  String get BookCollectionidentity => _BookCollectionidentity;

  set BookName(String value) {
    _BookName = value;
  }

  set BookCollectionidentity(String value) {
    _BookCollectionidentity = value;
  }

  set ImageURl(String value) {
    _ImageURl = value;
  }

  set Collection_type(String value) {
    _Collection_type = value;
  }
}