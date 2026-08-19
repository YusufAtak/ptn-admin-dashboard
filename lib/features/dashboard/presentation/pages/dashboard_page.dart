import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/sizes.dart';
import '../../../../core/presentation/widgets/language_switch_button.dart';
import '../../../../core/presentation/widgets/theme_switch_button.dart';
import '../../../../core/theme/dashboard_theme_colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';
import '../providers/dashboard_state.dart';
import '../widgets/charts_section.dart';
import '../widgets/dashboard_error_banner.dart';
import '../widgets/summary_cards.dart';
import '../widgets/user_table.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dashboardColors =
        theme.extension<DashboardThemeColors>() ?? DashboardThemeColors.light;
    final dashboardState = ref.watch(dashboardProvider);

    ref.listen<DashboardState>(dashboardProvider, (previous, next) {
      final messageKey = switch (next) {
        DashboardData(:final actionMessageKey) => actionMessageKey,
        _ => null,
      };
      final previousMessageKey = switch (previous) {
        DashboardData(:final actionMessageKey) => actionMessageKey,
        _ => null,
      };
      if (messageKey != null && messageKey != previousMessageKey) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(messageKey.tr())));
      }
    });

    final isCompact = MediaQuery.sizeOf(context).width < breakpointMobile;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(r8),
              child: Assets.icons.logo.image(
                width: iconLg,
                height: iconLg,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: mediumGap),
            Flexible(
              child: Text(
                'dashboard.title'.tr(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          if (!isCompact)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: compactGap,
              ),
              child: Chip(
                avatar: Icon(
                  Icons.circle,
                  color: dashboardColors.success,
                  size: iconSmall,
                ),
                label: Text('dashboard.live'.tr()),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: compactGap,
              ),
              child: Tooltip(
                message: 'dashboard.live'.tr(),
                child: Icon(
                  Icons.circle,
                  color: dashboardColors.success,
                  size: iconSmall,
                ),
              ),
            ),
          const ThemeSwitchButton(),
          const LanguageSwitchButton(),
          IconButton(
            icon: const Icon(Icons.logout, size: iconButton),
            onPressed: ref.read(authProvider.notifier).logout,
            tooltip: 'dashboard.logout'.tr(),
          ),
        ],
      ),
      body: switch (dashboardState) {
        DashboardInitial() ||
        DashboardLoading() => const Center(child: CircularProgressIndicator()),
        DashboardFailure(:final messageKey) => Padding(
          padding: const EdgeInsets.all(pagePadding),
          child: DashboardErrorBanner(
            messageKey: messageKey,
            onRetry: ref.read(dashboardProvider.notifier).refresh,
          ),
        ),
        DashboardData(:final snapshot, :final updatingUserIds) =>
          SingleChildScrollView(
            padding: const EdgeInsets.all(pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryCards(snapshot: snapshot),
                const SizedBox(height: sectionGap),
                Text(
                  'dashboard.last_seven_days'.tr(),
                  style: theme.textTheme.headlineLarge,
                ),
                const SizedBox(height: contentGap),
                ChartsSection(metrics: snapshot.weeklyMetrics),
                const SizedBox(height: largeSectionGap),
                Text(
                  'dashboard.recent_users'.tr(),
                  style: theme.textTheme.headlineLarge,
                ),
                const SizedBox(height: contentGap),
                UserTable(
                  users: snapshot.users,
                  userTypes: snapshot.userTypes,
                  updatingUserIds: updatingUserIds,
                  onUserTypeChanged: ref
                      .read(dashboardProvider.notifier)
                      .updateUserType,
                ),
              ],
            ),
          ),
      },
    );
  }
}
