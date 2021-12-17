import 'package:contactlistwithhive/core/helpers/permissions_helper.dart';
import 'package:contactlistwithhive/main.dart';
import 'package:contactlistwithhive/presentation/home/home_screen.dart';
import 'package:contactlistwithhive/presentation/not_granted_permission/not_granted_permission_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_test.mocks.dart';

@GenerateMocks([PermissionHelper])
void main() {
  late MockPermissionHelper mockPermissionHelper;

  setUp(() {
    mockPermissionHelper = MockPermissionHelper();
  });

  test("should call the NotGrantedPermissionScreen when permission to storage is not granted", () async {
    when(mockPermissionHelper.storageIsPermitted()).thenAnswer((_) async => false);
    final result = await getInitialPage(permissionHelper: mockPermissionHelper);
    expect(result, isA<NotGrantedPermissionScreen>());
  });

  test("should call MyApp when permission to storage is granted", () async {
    when(mockPermissionHelper.storageIsPermitted()).thenAnswer((_) async => true);
    final result = await getInitialPage(permissionHelper: mockPermissionHelper);
    expect(result, isA<MyApp>());
  });
}
