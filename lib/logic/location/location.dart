import 'package:mental_healthcare_app/logic/location/location_store.dart';

const double MAX_TOP_RIGHT_LONGITUDE = 82.971423;
const double MAX_TOP_RIGHT_LATITUDE = 10.482846;
const double MAX_BOTTOM_LEFT_LONGITUDE = 77.851350;
const double MAX_BOTTOM_LEFT_LATITUDE = 5.285498;

const double SRILANKA_LONGITUDE = 79.878074;
const double SRILANKA_LATITUDE = 6.8731;
const double SRILANKA_ZOOM = 11;

class Location {
  final double longitude;
  final double latitude;
  final String email;
  final String address;
  final String telephone2;
  final String telephone1;
  final String name;

  Location(
    this.longitude,
    this.latitude,
    this.email,
    this.address,
    this.telephone2,
    this.telephone1,
    this.name,
  );

  factory Location.fromJson(Map<String, dynamic> map) {
    double longitude = map["longitude"];
    double latitude = map["latitude"];
    String email = map["email"];
    String address = map["address"];
    String telephone2 = map["telephone2"];
    String telephone1 = map["telephone1"];
    String name = map["name"];
    return Location(
      longitude,
      latitude,
      email,
      address,
      telephone2,
      telephone1,
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
      "telephone2": telephone2,
      "name": name,
      "telephone1": telephone1
    }.toString();
  }
}
