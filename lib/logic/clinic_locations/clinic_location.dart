import 'package:mental_healthcare_app/logic/clinic_locations/test_locations.dart';

const double MAX_TOP_RIGHT_LONGITUDE = 82.971423;
const double MAX_TOP_RIGHT_LATITUDE = 10.482846;
const double MAX_BOTTOM_LEFT_LONGITUDE = 77.851350;
const double MAX_BOTTOM_LEFT_LATITUDE = 5.285498;

const double SRILANKA_LONGITUDE = 80.7718;
const double SRILANKA_LATITUDE = 7.8731;
const double SRILANKA_ZOOM = 7.4;

class ClinicLocation {
  final double _longitude;
  final double _latitude;
  final String _startTime;
  final String _endTime;
  final String _address;
  final String _about;
  final String _id;

  double get longitude => _longitude;
  double get latitude => _latitude;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get address => _address;
  String get about => _about;
  String get id => _id;

  ClinicLocation(
    this._longitude,
    this._latitude,
    this._startTime,
    this._endTime,
    this._address,
    this._about,
    this._id,
  );

  factory ClinicLocation.fromJson(Map<String, dynamic> map) {
    double longitude = map["longitude"];
    double latitude = map["latitude"];
    String startTime = map["start_time"];
    String endTime = map["end_time"];
    String address = map["address"];
    String about = map["about"];
    String id = map["id"];
    return ClinicLocation(
      longitude,
      latitude,
      startTime,
      endTime,
      address,
      about,
      id,
    );
  }

  static List<ClinicLocation> getTestLocations() {
    List<ClinicLocation> locations =
        getJsonLocations().map((v) => ClinicLocation.fromJson(v)).toList();
    return locations;
  }

  @override
  String toString() {
    return "\nlongitude: $_longitude\n"
        "latitude: $_latitude\n"
        "start_time: $_startTime\n"
        "end_time: $_endTime\n"
        "address: $_address\n"
        "id: $_id\n"
        "about: $_about\n";
  }
}
