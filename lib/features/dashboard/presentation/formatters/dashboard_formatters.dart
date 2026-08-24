import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

String formatCurrency(double value) {
  final formatter = NumberFormat('#,##0.00', 'tr_TR');
  return 'dashboard.currency_value'.tr(
    namedArgs: {
      'value': formatter.format(value),
    },
  );
}
