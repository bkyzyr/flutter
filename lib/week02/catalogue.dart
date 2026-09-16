import 'models.dart';

class Library {
  final List<LibraryItem> items = [];

  late final DateTime openedAt;
  String? _cachedReport;

  void open() {
    openedAt = DateTime.now();
  }

  void add(LibraryItem item) {
    items.add(item);
  }

  Book? findByTitle(String title) {
    for (final item in items) {
      if (item is Book && item.title == title) {
        return item;
      }
    }
    return null;
  }

  String countryOf(String title) {
    final book = findByTitle(title);
    return book?.author.country ?? 'unknown';
  }

  String buildReport() {
    return _cachedReport ??= 'Library Report (Opened: $openedAt):\n'
        '${displayList.join('\n')}';
  }

  Iterable<String> get allTitles => items.map((e) => e.title);

  Iterable<Book> get booksAfter2010 =>
      items.whereType<Book>().where((b) => b.year > 2010);

  double get averagePageCount {
    final books = items.whereType<Book>();
    if (books.isEmpty) return 0.0;
    final total = books.fold<int>(0, (sum, b) => sum + b.pages);
    return total / books.length;
  }

  Map<String, int> get authorBookCounts => items.whereType<Book>().fold<Map<String, int>>(
    {},
        (acc, book) {
      acc[book.author.name] = (acc[book.author.name] ?? 0) + 1;
      return acc;
    },
  );

  Set<String> get distinctAuthors =>
      items.whereType<Book>().map((b) => b.author.name).toSet();

  Set<Genre> get presentGenres =>
      items.whereType<Book>().map((b) => b.genre).toSet();

  List<String> get displayList => [
    'CATALOGUE',
    for (final item in items) '${item.title} (${item.year})',
    ...distinctAuthors,
    if (items.whereType<Book>().any((b) => b.pages == 0)) '(incomplete data)',
  ];
}