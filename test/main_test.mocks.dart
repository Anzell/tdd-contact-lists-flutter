// Mocks generated by Mockito 5.0.16 from annotations
// in contactlistwithhive/test/main_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:contactlistwithhive/core/helpers/permissions_helper.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [PermissionHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockPermissionHelper extends _i1.Mock implements _i2.PermissionHelper {
  MockPermissionHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> storageIsPermitted() =>
      (super.noSuchMethod(Invocation.method(#storageIsPermitted, []),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<void> requestStoragePermission() =>
      (super.noSuchMethod(Invocation.method(#requestStoragePermission, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}
