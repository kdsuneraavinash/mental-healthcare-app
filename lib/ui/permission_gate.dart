import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionGate extends StatefulWidget {
  @override
  _PermissionGateState createState() => _PermissionGateState();

  PermissionGate(
      {@required this.permission,
      @required this.child,
      @required this.permissionRequestText,
      this.disabledWidget,
      this.restrictedWidget});

  final PermissionGroup permission;
  final Widget child;
  final Widget disabledWidget;
  final Widget restrictedWidget;
  final String permissionRequestText;
}

class _PermissionGateState extends State<PermissionGate> {
  PermissionStatus _permissionStatus;

  _PermissionGateState() {
    _permissionStatus = PermissionStatus.unknown;
  }

  @override
  Widget build(BuildContext context) {
    switch (_permissionStatus) {
      case PermissionStatus.granted:
        return widget.child;
      case PermissionStatus.denied:
        return _buildAskPermissionButton(Colors.red);
      case PermissionStatus.disabled:
        return widget.disabledWidget ??
            Container(
              child: Center(
                child: Text(
                  "Turn ON Location Settings",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              color: Colors.blueGrey,
            );
      case PermissionStatus.restricted:
        return widget.restrictedWidget ?? widget.child;
      case PermissionStatus.unknown:
      default:
        return _buildAskPermissionButton(Colors.blue);
    }
  }

  Widget _buildAskPermissionButton(Color color) {
    return Center(
      child: RaisedButton.icon(
        color: color,
        onPressed: requestPermission,
        icon: Icon(FontAwesomeIcons.mobileAlt, color: Colors.white),
        label: Text(
          widget.permissionRequestText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() {
    final Future<PermissionStatus> statusFuture =
        PermissionHandler().checkPermissionStatus(widget.permission);

    statusFuture.then((PermissionStatus status) {
      setState(() {
        _permissionStatus = status;
      });
    });
  }

  void requestPermission() {
    final List<PermissionGroup> permissions = <PermissionGroup>[
      widget.permission
    ];
    final Future<Map<PermissionGroup, PermissionStatus>> requestFuture =
        PermissionHandler().requestPermissions(permissions);

    requestFuture
        .then((Map<PermissionGroup, PermissionStatus> permissionRequestResult) {
      setState(() {
        _permissionStatus = permissionRequestResult[widget.permission];
      });
    });
  }
}
