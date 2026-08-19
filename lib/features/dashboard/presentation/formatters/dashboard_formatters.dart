import 'package:easy_localization/easy_localization.dart';

import '../../../../constants/dashboard_constants.dart';

String formatCurrency(double value) => 'dashboard.currency_value'.tr(
  namedArgs: {
    'value': value.toStringAsFixed(DASHBOARD_CURRENCY_FRACTION_DIGITS),
  },
);
