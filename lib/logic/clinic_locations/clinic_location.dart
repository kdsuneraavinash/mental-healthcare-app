import 'package:mental_healthcare_app/logic/clinic_locations/test_locations.dart';

const double MAX_TOP_RIGHT_LONGITUDE = 82.971423;
const double MAX_TOP_RIGHT_LATITUDE = 10.482846;
const double MAX_BOTTOM_LEFT_LONGITUDE = 77.851350;
const double MAX_BOTTOM_LEFT_LATITUDE = 5.285498;

const double SRILANKA_LONGITUDE = 80.7718;
const double SRILANKA_LATITUDE = 7.8731;
const double SRILANKA_ZOOM = 7.4;

class ClinicLocation {
  final double longitude;
  final double latitude;
  final String startTime;
  final String endTime;
  final String address;
  final String about;
  final String id;

  ClinicLocation(
    this.longitude,
    this.latitude,
    this.startTime,
    this.endTime,
    this.address,
    this.about,
    this.id,
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
    return "\nlongitude: $longitude\n"
        "latitude: $latitude\n"
        "start_time: $startTime\n"
        "end_time: $endTime\n"
        "address: $address\n"
        "id: $id\n"
        "about: $about\n";
  }
}
