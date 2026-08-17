// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminUserSummary _$AdminUserSummaryFromJson(Map<String, dynamic> json) =>
    _AdminUserSummary(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      role: json['role'] as String,
      userType: json['userType'] as String,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$AdminUserSummaryToJson(_AdminUserSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'role': instance.role,
      'userType': instance.userType,
      'balance': instance.balance,
    };
