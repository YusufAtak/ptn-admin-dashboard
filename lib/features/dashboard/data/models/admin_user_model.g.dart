// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminUserModel _$AdminUserModelFromJson(Map<String, dynamic> json) =>
    _AdminUserModel(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      role: json['role'] as String? ?? USER_ROLE_PASSENGER,
      userType: json['userType'] as String? ?? '',
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AdminUserModelToJson(_AdminUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': instance.role,
      'userType': instance.userType,
      'createdAt': instance.createdAt,
    };
