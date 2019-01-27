import 'dart:async';
import 'package:mental_healthcare_app/logic/books/book.dart';

import 'package:rxdart/subjects.dart';

class BookBLoC {
  // Out Streams
  StreamController<List<Book>> _booksStreamController = BehaviorSubject();
  Stream<List<Book>> get booksStream => _booksStreamController.stream;

  BookBLoC() {
    _retrievebooks();
  }

  void _retrievebooks() async {
    _booksStreamController.add(Book.getTestBooks());
  }

  void dispose() {
    _booksStreamController.close();
  }
}
