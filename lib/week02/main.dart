// ignore_for_file: avoid_print
import 'data.dart';
import 'models.dart';
import 'catalogue.dart';
import 'shelf_state.dart';

void main() {
  final library = Library();
  library.open();

  for (final json in rawBooks) {
    final book = Book.fromJson(json);
    library.add(book);
  }

  print('=== REPORT ===');
  print(library.buildReport());

  print('\n=== LEVEL 4 QUERIES ===');
  print('All Titles: ${library.allTitles.toList()}');
  print('Books after 2010: ${library.booksAfter2010.map((b) => b.title).toList()}');
  print('Average page count: ${library.averagePageCount.toStringAsFixed(1)}');
  print('Author book counts: ${library.authorBookCounts}');
  print('Distinct authors: ${library.distinctAuthors}');
  print('Present genres: ${library.presentGenres.map((g) => g.label).toList()}');

  print('\n=== LEVEL 5 DART 3 FEATURES ===');
  final allBooks = library.items.whereType<Book>().toList();
  final stats = statsOf(allBooks);
  print('Stats Record -> Count: ${stats.count}, Avg Pages: ${stats.avgPages.toStringAsFixed(1)}');

  final states = <ShelfState>[
    Empty(),
    Ready(allBooks),
    Broken('Hardware failure'),
  ];

  for (final state in states) {
    print(describe(state));
  }
}