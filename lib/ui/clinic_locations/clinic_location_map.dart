import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mental_healthcare_app/bloc/clinic_location_map_bloc.dart';
import 'package:mental_healthcare_app/logic/clinic_locations/clinic_location.dart';
import 'package:mental_healthcare_app/ui/permission_gate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

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
    bloc.locationsStream.listen(_addMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clinic Locations"),
        backgroundColor: theme.UIColors.clinicColor,
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
                onMapCreated: _onGoogleMapCreated,
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<ClinicLocation>(
                stream: bloc.selectedLocationStream,
                builder: (_, snapshot) {
                  bool loaded = snapshot.hasData && snapshot.data != null;
                  return IgnorePointer(
                    ignoring: !loaded,
                    child: AnimatedOpacity(
                      opacity: loaded ? 0.8 : 0.0,
                      duration: Duration(seconds: 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: theme.UIColors.clinicOverlayColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(FontAwesomeIcons.hospitalSymbol,
                                      color: theme
                                          .UIColors.clinicOverlayTextColor),
                                  title: Text(
                                    loaded
                                        ? "Time ${snapshot.data.startTime} : ${snapshot.data.endTime}"
                                        : "",
                                    style: TextStyle(
                                        color: theme
                                            .UIColors.clinicOverlayTextColor),
                                  ),
                                  subtitle: Text(
                                    loaded ? snapshot.data.address : "",
                                    style: TextStyle(
                                        color: theme
                                            .UIColors.clinicOverlayTextColor),
                                  ),
                                  trailing: IconButton(
                                      icon: Icon(FontAwesomeIcons.times,
                                          color: theme
                                              .UIColors.clinicOverlayTextColor),
                                      onPressed: () {
                                        bloc.mapMarkerSelectedSink.add(null);
                                      }),
                                ),
                                Text(
                                  loaded ? snapshot.data.about : "",
                                  style: TextStyle(
                                      color: theme
                                          .UIColors.clinicOverlayTextColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void _onGoogleMapCreated(GoogleMapController controller) {
    mapController = controller;
    bloc.mapLoadedSink.add(true);
    mapController.onMarkerTapped.add((marker) {
      bloc.mapMarkerSelectedSink.add(marker);
    });
  }

  void _addMarker(ClinicLocation location) {
    if (mapController == null) return;
    if (location == null) return;

    MarkerOptions markerOptions = MarkerOptions(
        position: LatLng(location.latitude, location.longitude),
        infoWindowText: InfoWindowText("ID", location.id));
    mapController.addMarker(markerOptions);
  }
}
