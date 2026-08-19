import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/firestore_constants.dart';
import '../../domain/entities/admin_user_summary.dart';

part 'admin_user_model.freezed.dart';
part 'admin_user_model.g.dart';

@freezed
abstract class AdminUserModel with _$AdminUserModel {
  const factory AdminUserModel({
    required String id,
    @Default('') String email,
    @Default('') String displayName,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default(USER_ROLE_PASSENGER) String role,
    @Default('') String userType,
    @Default(0) int createdAt,
  }) = _AdminUserModel;

  const AdminUserModel._();

  factory AdminUserModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserModelFromJson(json);

  AdminUserSummary toDomain({required double balance}) {
    final resolvedName = displayName.isNotEmpty
        ? displayName
        : '$firstName $lastName'.trim();
    return AdminUserSummary(
      id: id,
      email: email,
      displayName: resolvedName,
      role: role,
      userTypeId: userType,
      balance: balance,
    );
  }
}
