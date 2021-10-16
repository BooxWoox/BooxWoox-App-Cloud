class BookShort {
/*
{
  "id": 19,
  "available": 1,
  "book_title": "Chamber of Secrtes",
  "img_url": null,
  "tags": "thriller",
  "genre": "thriller"
} 
*/

  int id;
  int available;
  String bookTitle;
  String imgUrl;
  String tags;
  String genre;

  BookShort({
    this.id,
    this.available,
    this.bookTitle,
    this.imgUrl,
    this.tags,
    this.genre,
  });
  BookShort.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    available = json["available"]?.toInt();
    bookTitle = json["book_title"]?.toString();
    imgUrl = json["img_url"]?.toString();
    tags = json["tags"]?.toString();
    genre = json["genre"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["available"] = available;
    data["book_title"] = bookTitle;
    data["img_url"] = imgUrl;
    data["tags"] = tags;
    data["genre"] = genre;
    return data;
  }
}

class BookDetailed {
/*
{
  "id": 25,
  "owner_id": 2,
  "available": 0,
  "Condition_book": "new",
  "isbn_no": "bcbcfckofnifkvrvkr",
  "mrp": "500",
  "created_date": "10/01/2021, 08:18:43",
  "is_approved": 1,
  "author": "J.K ROWLING",
  "book_title": "Prisoner of Askaban",
  "img_url": "",
  "description": "A very nice booK",
  "tags": "suspense",
  "genre": "thriller,adventure",
  "is_borrowed": 1,
  "lending_charge": 30,
  "location": "Bitha,Patna,Bihar,801106",
  "rent_duration": null,
  "deposite": null
} 
*/

  int id;
  int ownerId;
  int available;
  String ConditionBook;
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
  String rentDuration;
  String deposit;

  BookDetailed({
    this.id,
    this.ownerId,
    this.available,
    this.ConditionBook,
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
  });
  BookDetailed.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    ownerId = json["owner_id"]?.toInt();
    available = json["available"]?.toInt();
    ConditionBook = json["Condition_book"]?.toString();
    isbnNo = json["isbn_no"]?.toString();
    mrp = json["mrp"]?.toString();
    createdDate = json["created_date"]?.toString();
    isApproved = json["is_approved"]?.toInt();
    author = json["author"]?.toString();
    bookTitle = json["book_title"]?.toString();
    imgUrl = json["img_url"]?.toString();
    description = json["description"]?.toString();
    tags = json["tags"]?.toString();
    genre = json["genre"]?.toString();
    isBorrowed = json["is_borrowed"]?.toInt();
    lendingCharge = json["lending_charge"]?.toInt();
    location = json["location"]?.toString();
    rentDuration = json["rent_duration"]?.toString();
    deposit = json["deposit"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["owner_id"] = ownerId;
    data["available"] = available;
    data["Condition_book"] = ConditionBook;
    data["isbn_no"] = isbnNo;
    data["mrp"] = mrp;
    data["created_date"] = createdDate;
    data["is_approved"] = isApproved;
    data["author"] = author;
    data["book_title"] = bookTitle;
    data["img_url"] = imgUrl;
    data["description"] = description;
    data["tags"] = tags;
    data["genre"] = genre;
    data["is_borrowed"] = isBorrowed;
    data["lending_charge"] = lendingCharge;
    data["location"] = location;
    data["rent_duration"] = rentDuration;
    data["deposit"] = deposit;
    return data;
  }
}


class AddBook {
/*
{
  "book_title": "Lord of Rings",
  "mrp": 600,
  "condition": "new",
  "isbn": "bcbcfckofnifkvrvkr",
  "author": "J. R. R. Tolkien",
  "gentags": "mystery",
  "tags": "action",
  "description": "A very nice booK"
} 
*/

  String bookTitle;
  int mrp;
  String condition;
  String isbn;
  String author;
  String gentags;
  String tags;
  String description;

  AddBook({
    this.bookTitle,
    this.mrp,
    this.condition,
    this.isbn,
    this.author,
    this.gentags,
    this.tags,
    this.description,
  });
  AddBook.fromJson(Map<String, dynamic> json) {
    bookTitle = json["book_title"]?.toString();
    mrp = json["mrp"]?.toInt();
    condition = json["condition"]?.toString();
    isbn = json["isbn"]?.toString();
    author = json["author"]?.toString();
    gentags = json["gentags"]?.toString();
    tags = json["tags"]?.toString();
    description = json["description"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["book_title"] = bookTitle;
    data["mrp"] = mrp;
    data["condition"] = condition;
    data["isbn"] = isbn;
    data["author"] = author;
    data["gentags"] = gentags;
    data["tags"] = tags;
    data["description"] = description;
    return data;
  }
}

