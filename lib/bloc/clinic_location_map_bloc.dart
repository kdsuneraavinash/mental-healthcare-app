import 'dart:async';

import 'package:mental_healthcare_app/logic/clinic_locations/clinic_location.dart';
import 'package:rxdart/subjects.dart';

class ClinicLocationMapBLoC {
  // Out Streams
  StreamController<List<ClinicLocation>> _locationsStreamController =
      BehaviorSubject(seedValue: []);
  Stream<List<ClinicLocation>> get locationsStream =>
      _locationsStreamController.stream;

  // In Streams
  StreamController<bool> _mapLoadedStreamController =
      BehaviorSubject(seedValue: false);
  Sink<bool> get mapLoadedSink => _mapLoadedStreamController.sink;

  void dispose() {
    _locationsStreamController.close();
    _mapLoadedStreamController.close();
  }

  ClinicLocationMapBLoC() {
    _mapLoadedStreamController.stream.listen((v) {
      if (v) _locationsStreamController.add(ClinicLocation.getTestLocations());
    });
  }
}
