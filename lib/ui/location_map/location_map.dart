import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mental_healthcare_app/bloc/location_map_bloc.dart';
import 'package:mental_healthcare_app/localization/localization.dart';
import 'package:mental_healthcare_app/logic/location/location.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/contact_helper.dart';

class LocationMap extends StatefulWidget {
  @override
  LocationMapState createState() {
    return LocationMapState();
  }
}

class LocationMapState extends State<LocationMap> {
  GoogleMapController _mapController;
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
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            options: GoogleMapOptions(
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
        Positioned(
          top: 0.0,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<Location>(
              stream: bloc.selectedLocationStream,
              builder: (_, snapshot) {
                bool loaded = snapshot.hasData && snapshot.data != null;
                return IgnorePointer(
                  ignoring: !loaded,
                  child: loaded
                      ? Opacity(
                          opacity: loaded ? 1.0 : 0.0,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildOverlay(snapshot.data)),
                        )
                      : Container(),
                );
              }),
        ),
      ],
    );
  }

  void _onGoogleMapCreated(GoogleMapController controller) {
    _mapController = controller;
    bloc.mapLoadedSink.add(true);
    _mapController.onMarkerTapped.add((marker) {
      bloc.mapMarkerSelectedSink.add(marker);
    });
  }

  void _addMarker(Location location) {
    if (_mapController == null) return;
    if (location == null) return;
    MarkerOptions markerOptions = MarkerOptions(
        position: LatLng(location.latitude, location.longitude),
        infoWindowText: InfoWindowText(location.name, location.email));
    _mapController.addMarker(markerOptions);
  }

  Widget _buildOverlay(Location location) {
    return Card(
      color: theme.UIColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                location.name,
                style: theme.UITextThemes()
                    .locationOverlayText
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${location.address}\n\n"
                    "Tel: ${location.telephone}\n"
                    "Fax: ${location.fax}",
                style: TextStyle(
                  color: theme.UITextThemes().locationOverlayText.color,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () => ContactHelper.launchAction(
                            location.telephone.split("/")[0].trim(),
                            LaunchMethod.CALL),
                        icon: Icon(Icons.call),
                      ),
                    ),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () => ContactHelper.launchAction(
                            location.email.trim(), LaunchMethod.MAIL),
                        icon: Icon(Icons.email),
                      ),
                    ),
                  ],
                ),
                OutlineButton(
                  child: Text("Close",
                      style: theme.UITextThemes().locationOverlayText),
                  onPressed: () => bloc.mapMarkerSelectedSink.add(null),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
