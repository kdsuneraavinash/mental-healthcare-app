import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mental_healthcare_app/logic/clinic_locations/clinic_location.dart';
import 'package:rxdart/subjects.dart';

class ClinicLocationMapBLoC {
  Map<String, ClinicLocation> _clinicLocations;

  // Out Streams
  StreamController<ClinicLocation> _locationsStreamController =
      BehaviorSubject(seedValue: null);
  Stream<ClinicLocation> get locationsStream =>
      _locationsStreamController.stream;

  StreamController<ClinicLocation> _selectedLocationStreamController =
      BehaviorSubject(seedValue: null);
  Stream<ClinicLocation> get selectedLocationStream =>
      _selectedLocationStreamController.stream;

  // In Streams
  StreamController<bool> _mapLoadedStreamController =
      BehaviorSubject(seedValue: false);
  Sink<bool> get mapLoadedSink => _mapLoadedStreamController.sink;

  StreamController<Marker> _mapMarkerSelectedStreamController =
      BehaviorSubject();
  Sink<Marker> get mapMarkerSelectedSink =>
      _mapMarkerSelectedStreamController.sink;

  void dispose() {
    _locationsStreamController.close();
    _mapLoadedStreamController.close();
    _mapMarkerSelectedStreamController.close();
    _selectedLocationStreamController.close();
  }

  ClinicLocationMapBLoC() {
    _clinicLocations = {};

    _mapLoadedStreamController.stream.listen((v) {
      if (!v) return;

      for (ClinicLocation location in ClinicLocation.getTestLocations()) {
        _clinicLocations[location.id] = location;
        _locationsStreamController.add(location);
      }
    });

    _mapMarkerSelectedStreamController.stream.listen((marker) {
      if (marker == null) {
        _selectedLocationStreamController.add(null);
        return;
      }
      ClinicLocation location =
          _clinicLocations[marker.options.infoWindowText.snippet];
      if (location == null) return;
      _selectedLocationStreamController.add(location);
    });
  }
}
