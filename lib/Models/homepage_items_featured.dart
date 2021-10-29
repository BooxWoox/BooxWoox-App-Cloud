import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class homepage_items_featured {
  int id;
  int ownerId;
  int available;
  String conditionBook;
  String isbnNo;
  String mrp;
  String createdDate;
  int isApproved;
  String author;
  String bookTitle;
  String imgUrl;
  String description;
  String tags;
  String genre;
  int isBorrowed;
  int lendingCharge;
  String location;
  double rentDuration;
  double deposit;
  String latitude;
  String longitude;

  homepage_items_featured(
      {this.id,
      this.ownerId,
      this.available,
      this.conditionBook,
      this.isbnNo,
      this.mrp,
      this.createdDate,
      this.isApproved,
      this.author,
      this.bookTitle,
      this.imgUrl,
      this.description,
      this.tags,
      this.genre,
      this.isBorrowed,
      this.lendingCharge,
      this.location,
      this.rentDuration,
      this.deposit,
      this.latitude,
      this.longitude});

  homepage_items_featured.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    available = json['available'];
    conditionBook = json['Condition_book'];
    isbnNo = json['isbn_no'];
    mrp = json['mrp'];
    createdDate = json['created_date'];
    isApproved = json['is_approved'];
    author = json['author'];
    bookTitle = json['book_title'];
    imgUrl = json['img_url'];
    description = json['description'];
    tags = json['tags'];
    genre = json['genre'];
    isBorrowed = json['is_borrowed'];
    lendingCharge = json['lending_charge'];
    location = json['location'];
    rentDuration = json['rent_duration'];
    deposit = json['deposit'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['available'] = this.available;
    data['Condition_book'] = this.conditionBook;
    data['isbn_no'] = this.isbnNo;
    data['mrp'] = this.mrp;
    data['created_date'] = this.createdDate;
    data['is_approved'] = this.isApproved;
    data['author'] = this.author;
    data['book_title'] = this.bookTitle;
    data['img_url'] = this.imgUrl;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['genre'] = this.genre;
    data['is_borrowed'] = this.isBorrowed;
    data['lending_charge'] = this.lendingCharge;
    data['location'] = this.location;
    data['rent_duration'] = this.rentDuration;
    data['deposit'] = this.deposit;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
