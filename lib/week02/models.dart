class Author {
  final String name;
  final String? country;

  const Author({
    required this.name,
    this.country,
  });

  @override
  String toString() => country != null ? '$name ($country)' : name;
}

enum Genre {
  craft('Craft'),
  theory('Theory'),
  unknown('Unknown');

  final String label;
  const Genre(this.label);

  static Genre fromString(String? raw) {
    return switch (raw) {
      'craft' => Genre.craft,
      'theory' => Genre.theory,
      _ => Genre.unknown,
    };
  }
}

abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem({
    required this.title,
    required this.year,
  });

  String describe();

  bool get isOld => (DateTime.now().year - year) > 10;
}

mixin Borrowable on LibraryItem {
  String borrowLabel() => 'Borrowed: $title';
}

class Book extends LibraryItem with Borrowable {
  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  const Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final rawTitle = json['title'];
    final title = rawTitle is String ? rawTitle : 'Untitled';

    final rawYear = json['year'];
    final year = rawYear is int ? rawYear : 0;

    final rawPages = json['pages'];
    final pages = rawPages is int ? rawPages : 0;

    final rawAuthor = json['author'];
    final authorName = rawAuthor is String ? rawAuthor : 'Unknown';

    final rawCountry = json['country'];
    final country = rawCountry is String ? rawCountry : null;

    final rawGenre = json['genre'];
    final genreStr = rawGenre is String ? rawGenre : null;

    final rawDesc = json['description'];
    final description = rawDesc is String ? rawDesc : null;

    return Book(
      title: title,
      year: year,
      pages: pages,
      author: Author(name: authorName, country: country),
      genre: Genre.fromString(genreStr),
      description: description,
    );
  }

  bool get isLong => pages > 400;

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      year: year ?? this.year,
      pages: pages ?? this.pages,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
    );
  }

  @override
  String describe() => '$title ($year) - ${pages}p by ${author.name}';

  @override
  String toString() => describe();
}

class Magazine extends LibraryItem {
  final int issue;

  const Magazine({
    required super.title,
    required super.year,
    required this.issue,
  });

  @override
  String describe() => '$title Issue #$issue ($year)';
}

class Ghost implements LibraryItem {
  @override
  final String title;

  @override
  final int year;

  const Ghost({required this.title, required this.year});

  @override
  String describe() => 'Ghost Item: $title';

  @override
  bool get isOld => (DateTime.now().year - year) > 10;
}