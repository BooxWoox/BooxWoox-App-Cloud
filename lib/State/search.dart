import 'package:bookollab/Models/book.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchDelegate extends StateNotifier<List<BookShort>> {
  SearchDelegate() : super([]);

  List<BookShort> get booksList => state;

  updateQuery(String query, List<BookShort> books) {
    var search = query.toLowerCase();
    var temp = books.where((element) {
      if (element.bookTitle.toLowerCase().contains(search) ||
          element.genre.contains(search) ||
          element.tags.contains(search)) {
        return true;
      } else {
        return false;
      }
    }).toList();
    state = temp;
  }
}

final searchDelegateProvider =
    StateNotifierProvider.autoDispose<SearchDelegate, List<BookShort>>(
  (ref) => SearchDelegate(),
);

class SearchHomeDelegate extends StateNotifier<List<homepage_items_featured>> {
  SearchHomeDelegate() : super([]);

  List<homepage_items_featured> get booksList => state;

  updateHomeQuery(String query, List<homepage_items_featured> books) {
    var search = query.toLowerCase();
    var temp = books.where((element) {
      if (element.bookTitle.toLowerCase().contains(search) ||
          element.genre.contains(search) ||
          element.tags.contains(search)) {
        return true;
      } else {
        return false;
      }
    }).toList();
    state = temp;
  }
}
final searchHomeDelegateProvider =
    StateNotifierProvider.autoDispose<SearchHomeDelegate, List<homepage_items_featured>>(
  (ref) => SearchHomeDelegate(),
);