import 'package:bookollab/Models/homepage_items_featured.dart';
class maindisp_book_info_model{
  homepage_items_featured _item;

  homepage_items_featured get item => _item;

  set item(homepage_items_featured value) {
    _item = value;
  }

  maindisp_book_info_model(this._item);
}