import 'package:contactlistwithhive/core/helpers/permissions_helper.dart';
import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:contactlistwithhive/presentation/home/home_screen.dart';
import 'package:contactlistwithhive/presentation/not_granted_permission/not_granted_permission_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainInjector().init();
  runApp(await getInitialPage(permissionHelper: getIt<PermissionHelper>()));
}

Future<Widget> getInitialPage({required PermissionHelper permissionHelper}) async {
  if (await permissionHelper.storageIsPermitted()) {
    return MyApp();
  }
  return const NotGrantedPermissionScreen();
}
