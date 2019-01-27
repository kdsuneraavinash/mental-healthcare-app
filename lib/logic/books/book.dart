import 'package:mental_healthcare_app/logic/books/test_books.dart';
import 'package:html_unescape/html_unescape.dart';

const String Book_URL = "https://opentextbc.ca/api/v1/books";

class Book {
  final String title;
  final String description;
  final String image;

  Book({
    this.title,
    this.description,
    this.image,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    int length = 120;
    String desc = map["book_meta"]["pb_about_50"] ??
        map["book_meta"]["pb_about_140"] ??
        "";
    bool long = desc.length > length;
    return Book(
      title: HtmlUnescape().convert(map["book_meta"]["pb_title"]),
      description:
          (desc.substring(0, long ? length : desc.length) + (long ? "..." : "")),
      image: HtmlUnescape().convert(map["book_meta"]["pb_cover_image"]),
    );
  }

  static List<Book> getBooksFromJson(Map<String, dynamic> bookMaps) {
    Map books = bookMaps["data"];
    List<Book> parsedBooks = [];
    for (String kw in books.keys) {
      parsedBooks.add(Book.fromMap(books[kw]));
    }
    return parsedBooks;
  }

  static List<Book> getTestBooks() {
    return getBooksFromJson(getBooks());
  }

  @override
  String toString() {
    return "Book: " +
        {
          "title": title,
          "description": description,
          "image": image,
        }.toString();
  }
}
