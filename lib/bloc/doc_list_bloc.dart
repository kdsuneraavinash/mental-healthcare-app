import 'dart:async';

import 'package:mental_healthcare_app/logic/doc_list/doctor.dart';
import 'package:rxdart/subjects.dart';

class DocListBLoC{
  // Out Streams
  StreamController<List<Doctor>> _doctorStreamController = BehaviorSubject(seedValue: []);
  Stream<List<Doctor>> get doctorStream => _doctorStreamController.stream;

  void dispose(){
    _doctorStreamController.close();
  }

  DocListBLoC(){
    _doctorStreamController.add(Doctor.loadTestDoctors());
  }
}