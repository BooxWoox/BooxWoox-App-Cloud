import 'package:flutter/cupertino.dart';

class homepage_items_featured{
  String _Author;
  String _BookName;
  String _Collection_type;

  String get Author => _Author;

  set Author(String value) {
    _Author = value;
  }

  String _ImageURl;
  String _BookCollectionidentity;
  String _OwnerUID;

  homepage_items_featured(this._Author, this._BookName, this._Collection_type,
      this._ImageURl, this._BookCollectionidentity, this._OwnerUID);

  String get BookName => _BookName;

  set BookName(String value) {
    _BookName = value;
  }

  String get Collection_type => _Collection_type;

  set Collection_type(String value) {
    _Collection_type = value;
  }

  String get ImageURl => _ImageURl;

  set ImageURl(String value) {
    _ImageURl = value;
  }

  String get BookCollectionidentity => _BookCollectionidentity;

  set BookCollectionidentity(String value) {
    _BookCollectionidentity = value;
  }

  String get OwnerUID => _OwnerUID;

  set OwnerUID(String value) {
    _OwnerUID = value;
  }
}