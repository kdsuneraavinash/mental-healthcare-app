import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mental_healthcare_app/bloc/location_map_bloc.dart';
import 'package:mental_healthcare_app/localization/localization.dart';
import 'package:mental_healthcare_app/logic/location/location.dart';
import 'package:mental_healthcare_app/ui/permission_gate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

class LocationMap extends StatefulWidget {
  @override
  LocationMapState createState() {
    return LocationMapState();
  }
}

class LocationMapState extends State<LocationMap> {
  GoogleMapController mapController;
  final LocationMapBLoC bloc = LocationMapBLoC();

  LocationMapState() {
    bloc.mapLoadedSink.add(true);
    bloc.locationsStream.listen(_addMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalizationProvider.of(context)
            .localization
            .locationsAppBarTitle),
        backgroundColor: theme.UIColors.primaryColor,
      ),
      body: StreamBuilder(
        stream: bloc.startWindowStream,
        builder: (_, snapshot) => (snapshot.hasData && snapshot.data)
            ? _buildGoogleMap()
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildGoogleMap() {
    return Stack(
      children: <Widget>[
        PermissionGate(
          permissionRequestText: CustomLocalizationProvider.of(context)
              .localization
              .locationsGrantAccess,
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
                    northeast:
                        LatLng(MAX_TOP_RIGHT_LATITUDE, MAX_TOP_RIGHT_LONGITUDE),
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
          child: StreamBuilder<Location>(
              stream: bloc.selectedLocationStream,
              builder: (_, snapshot) {
                bool loaded = snapshot.hasData && snapshot.data != null;
                return IgnorePointer(
                  ignoring: !loaded,
                  child: Opacity(
                    opacity: loaded ? 1.0 : 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: theme.UIColors.secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.infoCircle,
                                  size: theme.UITextThemes()
                                      .locationOverlayText
                                      .fontSize,
                                  color: theme.UITextThemes()
                                      .locationOverlayText
                                      .color,
                                ),
                                title: Text(
                                  loaded ? snapshot.data.name : "",
                                  style: theme.UITextThemes()
                                      .locationOverlayText
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  loaded ? snapshot.data.email : "",
                                  style: theme.UITextThemes()
                                      .locationOverlayText
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  loaded
                                      ? "${snapshot.data.address}\n\n"
                                          "Tel: ${snapshot.data.telephone}\n"
                                          "Fax: ${snapshot.data.fax}"
                                      : "",
                                  style: TextStyle(
                                    color: theme.UITextThemes()
                                        .locationOverlayText
                                        .color,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: OutlineButton(
                                  child: Text("Close",
                                      style: theme.UITextThemes()
                                          .locationOverlayText),
                                  onPressed: () =>
                                      bloc.mapMarkerSelectedSink.add(null),
                                ),
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
    );
  }

  void _onGoogleMapCreated(GoogleMapController controller) {
    mapController = controller;
    bloc.mapLoadedSink.add(true);
    mapController.onMarkerTapped.add((marker) {
      bloc.mapMarkerSelectedSink.add(marker);
    });
  }

  void _addMarker(Location location) {
    if (mapController == null) return;
    if (location == null) return;

    MarkerOptions markerOptions = MarkerOptions(
        position: LatLng(location.latitude, location.longitude),
        infoWindowText: InfoWindowText(location.name, location.email));
    mapController.addMarker(markerOptions);
  }
}
