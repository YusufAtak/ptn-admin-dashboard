import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/user_type_code.dart';

part 'user_type_option.freezed.dart';

@freezed
abstract class UserTypeOption with _$UserTypeOption {
  const factory UserTypeOption({
    required String id,
    required UserTypeCode code,
  }) = _UserTypeOption;
}
