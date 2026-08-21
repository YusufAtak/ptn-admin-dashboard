enum DashboardDateRange {
  last7Days(7, 'dashboard.last_seven_days'),
  last14Days(14, 'dashboard.last_fourteen_days'),
  last30Days(30, 'dashboard.last_thirty_days');

  final int dayCount;
  final String labelKey;

  const DashboardDateRange(this.dayCount, this.labelKey);
}
