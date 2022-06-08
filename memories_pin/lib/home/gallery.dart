import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../main.dart';

class Gallery extends StatelessWidget {
  bool camPermissionsGranted = false;

  Future<bool> CamPermissionIsGranted() async {
    var _status = await Permission.camera.status.isGranted;
    camPermissionsGranted = _status;
    return _status;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('Gallery'),
    );
  }
}
