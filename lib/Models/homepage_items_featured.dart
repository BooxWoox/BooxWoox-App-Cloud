import 'package:flutter/cupertino.dart';

class homepage_items_featured{
  String _Author;
  String _BookName;
  String _Collection_type;


  String _ImageURl;
  String _BookCollectionidentity;
  String _OwnerUID;
  String _Seller_address;

  String get Author => _Author;

  set Author(String value) {
    _Author = value;
  }

  String _Seller_phnNumber;
  bool _availability;

  homepage_items_featured(
      this._Author,
      this._BookName,
      this._Collection_type,
      this._ImageURl,
      this._BookCollectionidentity,
      this._OwnerUID,
      this._Seller_address,
      this._Seller_phnNumber,
      this._availability);

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

  String get Seller_address => _Seller_address;

  set Seller_address(String value) {
    _Seller_address = value;
  }

  String get Seller_phnNumber => _Seller_phnNumber;

  set Seller_phnNumber(String value) {
    _Seller_phnNumber = value;
  }

  bool get availability => _availability;

  set availability(bool value) {
    _availability = value;
  }
}