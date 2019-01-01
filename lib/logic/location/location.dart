import 'package:mental_healthcare_app/logic/location/location_store.dart';

const double MAX_TOP_RIGHT_LONGITUDE = 82.971423;
const double MAX_TOP_RIGHT_LATITUDE = 10.482846;
const double MAX_BOTTOM_LEFT_LONGITUDE = 77.851350;
const double MAX_BOTTOM_LEFT_LATITUDE = 5.285498;

const double SRILANKA_LONGITUDE = 80.7718;
const double SRILANKA_LATITUDE = 7.8731;
const double SRILANKA_ZOOM = 7.4;

class Location {
  final double longitude;
  final double latitude;
  final String email;
  final String address;
  final String fax;
  final String telephone;
  final String name;

  Location(
    this.longitude,
    this.latitude,
    this.email,
    this.address,
    this.fax,
    this.telephone,
    this.name,
  );

  factory Location.fromJson(Map<String, dynamic> map) {
    double longitude = map["longitude"];
    double latitude = map["latitude"];
    String email = map["email"];
    String address = map["address"];
    String fax = map["fax"];
    String telephone = map["telephone"];
    String name = map["name"];
    return Location(
      longitude,
      latitude,
      email,
      address,
      fax,
      telephone,
      name,
    );
  }

  static List<Location> getLocations() {
    List<Location> locations =
        getJsonLocations().map((v) => Location.fromJson(v)).toList();
    return locations;
  }

  @override
  String toString() {
    return {
      "\nlongitude": longitude,
      "latitude": latitude,
      "email": email,
      "address": address,
      "fax": fax,
      "name": name,
      "telephone": telephone
    }.toString();
  }
}
