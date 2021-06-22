import 'package:flutter/cupertino.dart';

class homepage_items_featured{
  String _Author;
  String _BookName;
  String _Collection_type;
  int _Likes;
  int _Dislikes;
  double _Mrp;
  double _QuotedPrice;
  String _ImageURl;
  String _BookCollectionidentity;
  String _OwnerUID;
  String _Seller_address;
  String _Seller_phnNumber;
  bool _availability;
  String _Seller_FullName;
  String _Seller_UPI;
  List _Genretags;




  String get Author => _Author;

  set Author(String value) {
    _Author = value;
  }



  homepage_items_featured(
      this._Author,
      this._BookName,
      this._Collection_type,
      this._ImageURl,
      this._Likes,
      this._Dislikes,
      this._Mrp,
      this._QuotedPrice,
      this._BookCollectionidentity,
      this._OwnerUID,
      this._Seller_address,
      this._Seller_phnNumber,
      this._availability,
      this._Seller_FullName,
      this._Seller_UPI,
      this._Genretags);

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

  double get QuotedPrice => _QuotedPrice;

  String get BookCollectionidentity => _BookCollectionidentity;

  set BookCollectionidentity(String value) {
    _BookCollectionidentity = value;
  }

  String get OwnerUID => _OwnerUID;

  int get Likes => _Likes;

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

  String get Seller_FullName => _Seller_FullName;

  set Seller_FullName(String value) {
    _Seller_FullName = value;
  }

  int get Dislikes => _Dislikes;

  double get Mrp => _Mrp;

  String get Seller_UPI=>_Seller_UPI;

  set Seller_UPI(String value){
    _Seller_UPI=value;
  }

  List get Genretags => _Genretags;

  set Genretags(List value) {
    _Genretags = value;
  }

}