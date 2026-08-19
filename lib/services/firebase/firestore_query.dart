enum FirestoreFilterOperator { equalTo, greaterThanOrEqualTo, whereIn }

class FirestoreFilter {
  final String field;
  final FirestoreFilterOperator operator;
  final Object value;

  const FirestoreFilter({
    required this.field,
    required this.operator,
    required this.value,
  });
}

class FirestoreQueryOptions {
  final List<FirestoreFilter> filters;
  final String? orderBy;
  final bool descending;
  final int? limit;

  const FirestoreQueryOptions({
    this.filters = const [],
    this.orderBy,
    this.descending = false,
    this.limit,
  });
}
