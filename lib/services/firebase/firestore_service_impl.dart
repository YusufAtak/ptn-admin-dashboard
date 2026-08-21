import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../constants/firestore_constants.dart';
import '../../core/errors/exceptions.dart';
import 'firestore_query.dart';
import 'firestore_service.dart';

@LazySingleton(as: FirestoreService)
class FirestoreServiceImpl implements FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreServiceImpl(this._firestore);

  @override
  Future<Map<String, dynamic>?> getDocument(
    String collectionPath,
    String documentId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .get();
      final data = snapshot.data();
      if (!snapshot.exists || data == null) {
        return null;
      }
      return _normalizeDocument(snapshot.id, data);
    } on FirebaseException catch (error) {
      throw FirestoreServiceException(error.code, message: error.message);
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> watchCollection(
    String collectionPath, {
    FirestoreQueryOptions options = const FirestoreQueryOptions(),
  }) {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection(collectionPath);
      for (final filter in options.filters) {
        query = _applyFilter(query, filter);
      }
      if (options.orderBy case final field?) {
        query = query.orderBy(field, descending: options.descending);
      }
      if (options.limit case final limit?) {
        query = query.limit(limit);
      }

      return query.snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => _normalizeDocument(document.id, document.data()))
            .toList(growable: false),
      );
    } on FirebaseException catch (error) {
      throw FirestoreServiceException(error.code, message: error.message);
    }
  }

  @override
  Future<void> updateDocument(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data, {
    bool stampUpdatedAt = false,
  }) async {
    try {
      final payload = Map<String, dynamic>.from(data);
      if (stampUpdatedAt) {
        payload[FIELD_UPDATED_AT] = FieldValue.serverTimestamp();
      }
      await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .update(payload);
    } on FirebaseException catch (error) {
      throw FirestoreServiceException(error.code, message: error.message);
    }
  }

  Query<Map<String, dynamic>> _applyFilter(
    Query<Map<String, dynamic>> query,
    FirestoreFilter filter,
  ) => switch (filter.operator) {
    FirestoreFilterOperator.equalTo => query.where(
      filter.field,
      isEqualTo: filter.value,
    ),
    FirestoreFilterOperator.greaterThanOrEqualTo => query.where(
      filter.field,
      isGreaterThanOrEqualTo: filter.value,
    ),
    FirestoreFilterOperator.whereIn => query.where(
      filter.field,
      whereIn: filter.value as List<Object>,
    ),
  };

  Map<String, dynamic> _normalizeDocument(
    String documentId,
    Map<String, dynamic> data,
  ) => {
    for (final entry in data.entries) entry.key: _normalizeValue(entry.value),
    FIELD_DOCUMENT_ID: documentId,
  };

  Object? _normalizeValue(Object? value) => switch (value) {
    final Timestamp timestamp => timestamp.millisecondsSinceEpoch,
    final Map<String, dynamic> map => {
      for (final entry in map.entries) entry.key: _normalizeValue(entry.value),
    },
    final List<Object?> values => values.map(_normalizeValue).toList(),
    _ => value,
  };
}
