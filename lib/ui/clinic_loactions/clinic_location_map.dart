import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mental_healthcare_app/bloc/clinic_location_map_bloc.dart';
import 'package:mental_healthcare_app/logic/clinic_locations/clinic_location.dart';
import 'package:mental_healthcare_app/ui/permission_gate.dart';
import 'package:permission_handler/permission_handler.dart';

class ClinicLocationMap extends StatefulWidget {
  @override
  ClinicLocationMapState createState() {
    return ClinicLocationMapState();
  }
}

class ClinicLocationMapState extends State<ClinicLocationMap> {
  GoogleMapController mapController;
  final ClinicLocationMapBLoC bloc = ClinicLocationMapBLoC();

  ClinicLocationMapState() {
    bloc.mapLoadedSink.add(true);
    bloc.locationsStream.listen(_addAllMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clinic Locations"),
      ),
      body: Stack(
        children: <Widget>[
          PermissionGate(
            permissionRequestText: "Grant Location Access",
            permission: PermissionGroup.location,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                options: GoogleMapOptions(
                  myLocationEnabled: true,
                  cameraTargetBounds: CameraTargetBounds(
                    LatLngBounds(
                      southwest: LatLng(
                          MAX_BOTTOM_LEFT_LATITUDE, MAX_BOTTOM_LEFT_LONGITUDE),
                      northeast: LatLng(
                          MAX_TOP_RIGHT_LATITUDE, MAX_TOP_RIGHT_LONGITUDE),
                    ),
                  ),
                  cameraPosition: CameraPosition(
                    target: LatLng(SRILANKA_LATITUDE, SRILANKA_LONGITUDE),
                    zoom: SRILANKA_ZOOM,
                  ),
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  bloc.mapLoadedSink.add(true);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(FontAwesomeIcons.search),
      ),
    );
  }

  void _addAllMarkers(List<ClinicLocation> locations) {
    if (mapController == null) return;
    for (ClinicLocation location in locations) {
      mapController.addMarker(MarkerOptions(
          position: LatLng(location.latitude, location.longitude),
          infoWindowText:
              InfoWindowText("Time ${location.startTime} - ${location.endTime}", location.address)));
    }
  }
}
