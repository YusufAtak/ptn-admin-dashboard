import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';

class DashboardErrorBanner extends StatelessWidget {
  final String messageKey;
  final VoidCallback onRetry;

  const DashboardErrorBanner({
    required this.messageKey,
    required this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.errorContainer,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Padding(
        padding: const EdgeInsets.all(contentGap),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: theme.colorScheme.onErrorContainer,
              size: iconButton,
            ),
            const SizedBox(width: mediumGap),
            Expanded(child: Text(messageKey.tr())),
            TextButton(onPressed: onRetry, child: Text('common.retry'.tr())),
          ],
        ),
      ),
    );
  }
}
