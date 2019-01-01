import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mental_healthcare_app/logic/location/location.dart';
import 'package:rxdart/subjects.dart';

class LocationMapBLoC {
  Map<String, Location> _locations;

  // Out Streams
  StreamController<Location> _locationsStreamController =
      BehaviorSubject(seedValue: null);
  Stream<Location> get locationsStream =>
      _locationsStreamController.stream;

  StreamController<Location> _selectedLocationStreamController =
      BehaviorSubject(seedValue: null);
  Stream<Location> get selectedLocationStream =>
      _selectedLocationStreamController.stream;

  StreamController<bool> _startWindowStreamController =
      BehaviorSubject(seedValue: false);
  Stream<bool> get startWindowStream => _startWindowStreamController.stream;

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
    _startWindowStreamController.close();
  }

  LocationMapBLoC() {
    _locations = {};

    Future.delayed(Duration(milliseconds: 1200)).then((_) {
      _startWindowStreamController.add(true);
    });

    _mapLoadedStreamController.stream.listen((v) {
      if (!v) return;

      for (Location location in Location.getLocations()) {
        _locations[location.name] = location;
        _locationsStreamController.add(location);
      }
    });

    _mapMarkerSelectedStreamController.stream.listen((marker) {
      if (marker == null) {
        _selectedLocationStreamController.add(null);
        return;
      }
      Location location =
          _locations[marker.options.infoWindowText.title];
      if (location == null) return;
      _selectedLocationStreamController.add(location);
    });
  }
}
