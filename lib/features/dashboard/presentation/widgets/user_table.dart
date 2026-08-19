import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/dashboard_constants.dart';
import '../../domain/entities/admin_user_summary.dart';
import '../../domain/entities/user_type_option.dart';
import '../extensions/user_type_code_localization.dart';
import '../formatters/dashboard_formatters.dart';

class UserTable extends StatelessWidget {
  final List<AdminUserSummary> users;
  final List<UserTypeOption> userTypes;
  final Set<String> updatingUserIds;
  final void Function(String userId, String userTypeId) onUserTypeChanged;

  const UserTable({
    required this.users,
    required this.userTypes,
    required this.updatingUserIds,
    required this.onUserTypeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('dashboard.columns.id'.tr())),
              DataColumn(label: Text('dashboard.columns.name'.tr())),
              DataColumn(label: Text('dashboard.columns.email'.tr())),
              DataColumn(label: Text('dashboard.columns.balance'.tr())),
              DataColumn(label: Text('dashboard.columns.user_type'.tr())),
            ],
            rows: users
                .map(
                  (user) => DataRow(
                    cells: [
                      DataCell(Text(_shortId(user.id))),
                      DataCell(
                        Text(
                          user.displayName.isEmpty
                              ? 'dashboard.anonymous_user'.tr()
                              : user.displayName,
                        ),
                      ),
                      DataCell(Text(user.email)),
                      DataCell(Text(formatCurrency(user.balance))),
                      DataCell(
                        _UserTypeDropdown(
                          user: user,
                          options: userTypes,
                          isUpdating: updatingUserIds.contains(user.id),
                          onChanged: onUserTypeChanged,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }

  String _shortId(String id) =>
      id.length <= DASHBOARD_SHORTENED_ID_LENGTH
      ? id
      : '${id.substring(0, DASHBOARD_SHORTENED_ID_LENGTH)}'
            '$DASHBOARD_SHORTENED_ID_SUFFIX';
}

class _UserTypeDropdown extends StatelessWidget {
  final AdminUserSummary user;
  final List<UserTypeOption> options;
  final bool isUpdating;
  final void Function(String userId, String userTypeId) onChanged;

  const _UserTypeDropdown({
    required this.user,
    required this.options,
    required this.isUpdating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selectedId = options.any((option) => option.id == user.userTypeId)
        ? user.userTypeId
        : options.first.id;

    final theme = Theme.of(context);
    return DropdownButton<String>(
      value: selectedId,
      dropdownColor: theme.cardTheme.color,
      underline: const SizedBox.shrink(),
      items: options
          .map(
            (option) => DropdownMenuItem<String>(
              value: option.id,
              child: Text(option.code.labelKey.tr()),
            ),
          )
          .toList(growable: false),
      onChanged: isUpdating
          ? null
          : (newValue) {
              if (newValue != null && newValue != user.userTypeId) {
                onChanged(user.id, newValue);
              }
            },
    );
  }
}
