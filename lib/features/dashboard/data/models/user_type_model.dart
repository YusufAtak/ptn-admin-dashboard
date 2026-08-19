import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/firestore_constants.dart';
import '../../domain/entities/user_type_option.dart';
import '../../domain/enums/user_type_code.dart';

part 'user_type_model.freezed.dart';
part 'user_type_model.g.dart';

@freezed
abstract class UserTypeModel with _$UserTypeModel {
  const factory UserTypeModel({required String id, @Default('') String name}) =
      _UserTypeModel;

  const UserTypeModel._();

  factory UserTypeModel.fromJson(Map<String, dynamic> json) =>
      _$UserTypeModelFromJson(json);

  UserTypeOption? toDomain() {
    final code = switch (id) {
      USER_TYPE_FULL => UserTypeCode.full,
      USER_TYPE_STUDENT => UserTypeCode.student,
      USER_TYPE_ELDERLY => UserTypeCode.elderly,
      _ => null,
    };
    return code == null ? null : UserTypeOption(id: id, code: code);
  }

  static const fallbackOptions = [
    UserTypeOption(id: USER_TYPE_FULL, code: UserTypeCode.full),
    UserTypeOption(id: USER_TYPE_STUDENT, code: UserTypeCode.student),
    UserTypeOption(id: USER_TYPE_ELDERLY, code: UserTypeCode.elderly),
  ];
}
