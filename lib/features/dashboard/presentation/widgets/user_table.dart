import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../constants/dashboard_constants.dart';
import '../../../../constants/opacities.dart';
import '../../../../constants/sizes.dart';
import '../../../../core/theme/dashboard_theme_colors.dart';
import '../../domain/entities/admin_user_summary.dart';
import '../../domain/entities/user_type_option.dart';
import '../extensions/user_type_code_localization.dart';
import '../formatters/dashboard_formatters.dart';

class UserTable extends HookWidget {
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
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    useEffect(() {
      void listener() {
        searchQuery.value = searchController.text.trim().toLowerCase();
      }

      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    final filteredUsers = useMemoized(() {
      if (searchQuery.value.isEmpty) return users;
      return users.where((user) {
        final nameMatch =
            user.displayName.toLowerCase().contains(searchQuery.value);
        final emailMatch = user.email.toLowerCase().contains(searchQuery.value);
        final idMatch = user.id.toLowerCase().contains(searchQuery.value);
        return nameMatch || emailMatch || idMatch;
      }).toList();
    }, [users, searchQuery.value]);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < breakpointMobile;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Input
            _SearchField(
              controller: searchController,
              onClear: searchController.clear,
            ),
            const SizedBox(height: mediumGap),

            // Content
            if (filteredUsers.isEmpty)
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(pagePadding),
                  child: Center(
                    child: Text(
                      'dashboard.no_users_found'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              )
            else if (isMobile)
              _UserCardList(
                users: filteredUsers,
                userTypes: userTypes,
                updatingUserIds: updatingUserIds,
                onUserTypeChanged: onUserTypeChanged,
              )
            else
              _UserDataTable(
                users: filteredUsers,
                userTypes: userTypes,
                updatingUserIds: updatingUserIds,
                onUserTypeChanged: onUserTypeChanged,
              ),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'dashboard.search_user_hint'.tr(),
        prefixIcon: const Icon(Icons.search, size: iconButton),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: iconSmall),
                onPressed: onClear,
              )
            : null,
        filled: true,
        fillColor: theme.cardTheme.color,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: mediumGap,
          vertical: compactGap,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: HALF),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: HALF),
          ),
        ),
      ),
    );
  }
}

class _UserCardList extends StatelessWidget {
  final List<AdminUserSummary> users;
  final List<UserTypeOption> userTypes;
  final Set<String> updatingUserIds;
  final void Function(String userId, String userTypeId) onUserTypeChanged;

  const _UserCardList({
    required this.users,
    required this.userTypes,
    required this.updatingUserIds,
    required this.onUserTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (_, __) => const SizedBox(height: compactGap),
      itemBuilder: (context, index) {
        final user = users[index];
        return _UserCardItem(
          user: user,
          userTypes: userTypes,
          isUpdating: updatingUserIds.contains(user.id),
          onUserTypeChanged: onUserTypeChanged,
        );
      },
    );
  }
}

class _UserCardItem extends StatelessWidget {
  final AdminUserSummary user;
  final List<UserTypeOption> userTypes;
  final bool isUpdating;
  final void Function(String userId, String userTypeId) onUserTypeChanged;

  const _UserCardItem({
    required this.user,
    required this.userTypes,
    required this.isUpdating,
    required this.onUserTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dashboardColors =
        theme.extension<DashboardThemeColors>() ?? DashboardThemeColors.light;

    final displayName = user.displayName.isEmpty
        ? 'dashboard.anonymous_user'.tr()
        : user.displayName;

    final initial = displayName.isNotEmpty
        ? displayName.substring(0, 1).toUpperCase()
        : '';

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(cardPaddingMobile),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Avatar + Name/Email + Balance
            Row(
              children: [
                CircleAvatar(
                  radius: mobileAvatarSize / 2,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    initial,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: mediumGap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: smallGap),
                      Text(
                        user.email,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: compactGap),
                // Balance Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: compactGap,
                    vertical: smallGap,
                  ),
                  decoration: BoxDecoration(
                    color: dashboardColors.balance
                        .withValues(alpha: ICON_BACKGROUND),
                    borderRadius: BorderRadius.circular(badgeRadius),
                  ),
                  child: Text(
                    formatCurrency(user.balance),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: dashboardColors.balance,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: mediumGap),
            const Divider(height: 1),
            const SizedBox(height: compactGap),

            // Bottom Row: Tap-to-Copy ID Badge + User Type Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Short ID pill with tap-to-copy
                _UserIdPill(userId: user.id),

                // User Type Dropdown with loading indicator
                _UserTypeDropdown(
                  user: user,
                  options: userTypes,
                  isUpdating: isUpdating,
                  onChanged: onUserTypeChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UserDataTable extends StatelessWidget {
  final List<AdminUserSummary> users;
  final List<UserTypeOption> userTypes;
  final Set<String> updatingUserIds;
  final void Function(String userId, String userTypeId) onUserTypeChanged;

  const _UserDataTable({
    required this.users,
    required this.userTypes,
    required this.updatingUserIds,
    required this.onUserTypeChanged,
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
                      DataCell(_UserIdPill(userId: user.id)),
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
}

class _UserIdPill extends StatelessWidget {
  final String userId;

  const _UserIdPill({required this.userId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: 'dashboard.copy_id_tooltip'.tr(),
      child: InkWell(
        onTap: () => _copyUserIdToClipboard(context, userId),
        borderRadius: BorderRadius.circular(badgeRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: compactGap,
            vertical: smallGap,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(badgeRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _shortId(userId),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: smallGap),
              Icon(
                Icons.copy,
                size: iconSmall,
                color:
                    theme.colorScheme.onSurfaceVariant.withValues(alpha: HALF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _shortId(String id) => id.length <= DASHBOARD_SHORTENED_ID_LENGTH
      ? id
      : '${id.substring(0, DASHBOARD_SHORTENED_ID_LENGTH)}'
          '$DASHBOARD_SHORTENED_ID_SUFFIX';
}

void _copyUserIdToClipboard(BuildContext context, String userId) {
  Clipboard.setData(ClipboardData(text: userId));
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('dashboard.id_copied'.tr()),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      width: 280,
    ),
  );
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
    if (isUpdating) {
      return const SizedBox(
        width: progressIndicatorSize,
        height: progressIndicatorSize,
        child: CircularProgressIndicator(strokeWidth: progressStrokeWidth),
      );
    }

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
      onChanged: (newValue) {
        if (newValue != null && newValue != user.userTypeId) {
          onChanged(user.id, newValue);
        }
      },
    );
  }
}
