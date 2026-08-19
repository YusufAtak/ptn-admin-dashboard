import 'firestore_query.dart';

abstract interface class FirestoreService {
  Future<Map<String, dynamic>?> getDocument(
    String collectionPath,
    String documentId,
  );

  Stream<List<Map<String, dynamic>>> watchCollection(
    String collectionPath, {
    FirestoreQueryOptions options = const FirestoreQueryOptions(),
  });

  Future<void> updateDocument(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data, {
    bool stampUpdatedAt = false,
  });
}
