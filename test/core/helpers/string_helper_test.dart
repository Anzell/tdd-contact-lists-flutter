import 'package:contactlistwithhive/core/helpers/string_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'string_helper_test.mocks.dart';

@GenerateMocks([Uuid])
void main() {
  late StringHelper stringHelper;
  late Uuid mockUuid;

  setUp(() {
    mockUuid = MockUuid();
    stringHelper = StringHelperImpl(uidGenerateService: mockUuid);
  });

  final testUuid = "valid uuid";

  test("should return a any uuid", () {
    when(mockUuid.v4()).thenReturn(testUuid);
    final result = stringHelper.generateUniqueId;
    expect(result, testUuid);
  });
}
