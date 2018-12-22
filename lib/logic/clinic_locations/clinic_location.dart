import 'package:mental_healthcare_app/logic/clinic_locations/test_locations.dart';

const double MAX_TOP_RIGHT_LONGITUDE = 82.971423;
const double MAX_TOP_RIGHT_LATITUDE = 10.482846;
const double MAX_BOTTOM_LEFT_LONGITUDE = 77.851350;
const double MAX_BOTTOM_LEFT_LATITUDE = 5.285498;

const double SRILANKA_LONGITUDE = 80.7718;
const double SRILANKA_LATITUDE = 7.8731;
const double SRILANKA_ZOOM = 7.7;

class ClinicLocation {
  final double _longitude;
  final double _latitude;
  final String _startTime;
  final String _endTime;
  final String _address;
  final String _about;

  double get longitude => _longitude;
  double get latitude => _latitude;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get address => _address;
  String get about => _about;

  ClinicLocation(
    this._longitude,
    this._latitude,
    this._startTime,
    this._endTime,
    this._address,
    this._about,
  );

  factory ClinicLocation.fromJson(Map<String, dynamic> map) {
    double longitude = map["longitude"];
    double latitude = map["latitude"];
    String startTime = map["start_time"];
    String endTime = map["end_time"];
    String address = map["address"];
    String about = map["about"];
    return ClinicLocation(
      longitude,
      latitude,
      startTime,
      endTime,
      address,
      about,
    );
  }

  static List<ClinicLocation> getTestLocations() {
    List<ClinicLocation> locations =
        getJsonLocations().map((v) => ClinicLocation.fromJson(v)).toList();
    print(locations);
    return locations;
  }

  @override
  String toString() {
    return "\nlongitude: $_longitude\n"
        "latitude: $_latitude\n"
        "start_time: $_startTime\n"
        "end_time: $_endTime\n"
        "address: $_address\n"
        "about: $_about\n";
  }
}
