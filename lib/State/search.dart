import 'package:bookollab/Models/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchDelegate extends StateNotifier<List<BookShort>> {
  SearchDelegate(List<BookShort> state) : super(state);

  List<BookShort> get booksList => state;

  updateQuery(String query) {
    var temp = state.where((element) {
      if (element.bookTitle.contains(query) ||
          element.genre.contains(query) ||
          element.tags.contains(query)) {
        return true;
      } else {
        return false;
      }
    }).toList();
    state = temp;
  }
}

final searchDelegateProvider = StateNotifierProvider.family<SearchDelegate,
    List<BookShort>, List<BookShort>>(
  (ref, books) => SearchDelegate(books),
);
