import 'package:uuid/uuid.dart';

abstract class StringHelper {
  String get generateUniqueId;
}

class StringHelperImpl implements StringHelper {
  final Uuid uidGenerateService;

  StringHelperImpl({required this.uidGenerateService});

  @override
  String get generateUniqueId => uidGenerateService.v4();
}
