import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHelper {
  Future<bool> storageIsPermitted();
  Future<void> requestStoragePermission();
}

class PermissionsHelperImpl implements PermissionHelper {
  @override
  Future<bool> storageIsPermitted() async => await Permission.storage.isGranted;

  @override
  Future<void> requestStoragePermission() async {
    await Permission.storage.request();
  }
}
