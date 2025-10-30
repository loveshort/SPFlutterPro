import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();

  static Future<bool> request(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  static Future<bool> ensure(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted) return true;
    status = await permission.request();
    return status.isGranted;
  }

  static Future<bool> openSettings() async {
    return await openAppSettings();
  }
}


