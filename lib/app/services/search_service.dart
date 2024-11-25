import 'dart:developer';

class SearchService {
  /// List of text searchs
  /// Key is a index of search
  /// Value is a text of search
  final Map<int, String> textSearchs = {};

  void addSearch(int index, String text) {
    log("Add search: $text in index: $index", name: "SearchService");
    textSearchs[index] = text.toLowerCase();
  }

  void removeSearch(int index) {
    textSearchs.remove(index);
  }

  void clear() {
    textSearchs.clear();
  }

  List<int> search(String text) {
    text = text.toLowerCase().replaceAll(' ', '');

    log("Search: $text", name: "SearchService");

    final result = <int>[];
    final rest = <int>[];

    for (final index in textSearchs.keys) {
      if (textSearchs[index]!.contains(text)) {
        result.add(index);
      } else {
        rest.add(index);
      }
    }

    result.addAll(rest);
    return result;
  }
}
