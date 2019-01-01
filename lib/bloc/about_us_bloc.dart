import 'dart:async';

import 'package:mental_healthcare_app/logic/about_us/about_person.dart';
import 'package:rxdart/subjects.dart';

class AboutUsBLoC {
  // Out Streams
  StreamController<List<AboutPerson>> _aboutPersonStreamController =
      BehaviorSubject(seedValue: []);
  Stream<List<AboutPerson>> get aboutPersonStream => _aboutPersonStreamController.stream;

  void dispose() {
    _aboutPersonStreamController.close();
  }

  AboutUsBLoC() {
    _aboutPersonStreamController.add(AboutPerson.loadData());
  }
}
