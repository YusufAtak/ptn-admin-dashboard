import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptn_admin_dashboard/constants/firestore_constants.dart';
import 'package:ptn_admin_dashboard/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:ptn_admin_dashboard/services/firebase/firestore_query.dart';
import 'package:ptn_admin_dashboard/services/firebase/firestore_service.dart';

class _MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  late _MockFirestoreService firestoreService;
  late DashboardRepositoryImpl repository;
  late Map<String, StreamController<List<Map<String, dynamic>>>> controllers;

  setUpAll(() {
    registerFallbackValue(const FirestoreQueryOptions());
  });

  setUp(() {
    firestoreService = _MockFirestoreService();
    repository = DashboardRepositoryImpl(firestoreService);
    controllers = {
      PATH_USERS:
          StreamController<List<Map<String, dynamic>>>.broadcast(),
      PATH_WALLETS:
          StreamController<List<Map<String, dynamic>>>.broadcast(),
      PATH_TRANSACTIONS:
          StreamController<List<Map<String, dynamic>>>.broadcast(),
      PATH_USER_TYPES:
          StreamController<List<Map<String, dynamic>>>.broadcast(),
    };
    when(
      () => firestoreService.watchCollection(
        any(),
        options: any(named: 'options'),
      ),
    ).thenAnswer((invocation) {
      final path = invocation.positionalArguments.first as String;
      return controllers[path]!.stream;
    });
  });

  tearDown(() async {
    await Future.wait(
      controllers.values.map((controller) => controller.close()),
    );
  });

  test(
    'maps live Firestore documents into complete dashboard snapshot',
    () async {
      final referenceDate = DateTime(2026, 8, 17, 12);
      final resultFuture = repository.watchDashboard(referenceDate).first;

      controllers[PATH_USERS]!.add([
        {
          FIELD_DOCUMENT_ID: 'user-id',
          FIELD_EMAIL: 'passenger@example.com',
          FIELD_DISPLAY_NAME: 'Passenger',
          FIELD_ROLE: USER_ROLE_PASSENGER,
          FIELD_USER_TYPE: USER_TYPE_FULL,
          FIELD_CREATED_AT: referenceDate.millisecondsSinceEpoch,
        },
        {
          FIELD_DOCUMENT_ID: 'admin-id',
          FIELD_EMAIL: 'admin@example.com',
          FIELD_DISPLAY_NAME: 'Admin User',
          FIELD_ROLE: USER_ROLE_ADMIN,
          FIELD_USER_TYPE: USER_TYPE_FULL,
          FIELD_CREATED_AT: referenceDate.millisecondsSinceEpoch,
        },
        {
          FIELD_DOCUMENT_ID: 'validator-id',
          FIELD_EMAIL: 'validator@example.com',
          FIELD_DISPLAY_NAME: 'Validator Device',
          FIELD_ROLE: USER_ROLE_VALIDATOR,
          FIELD_USER_TYPE: USER_TYPE_FULL,
          FIELD_CREATED_AT: referenceDate.millisecondsSinceEpoch,
        },
      ]);
      controllers[PATH_WALLETS]!.add([
        {FIELD_DOCUMENT_ID: 'user-id', FIELD_BALANCE: 125.0},
      ]);
      controllers[PATH_TRANSACTIONS]!.add([
        {
          FIELD_AMOUNT: 10.0,
          FIELD_TYPE: TRANSACTION_TYPE_SPEND,
          FIELD_TIMESTAMP: referenceDate.millisecondsSinceEpoch,
        },
        {
          FIELD_AMOUNT: 0.0,
          FIELD_TYPE: TRANSACTION_TYPE_TICKET_USE,
          FIELD_TIMESTAMP: referenceDate.millisecondsSinceEpoch,
        },
        {
          FIELD_AMOUNT: 20.0,
          FIELD_TYPE: TRANSACTION_TYPE_SPEND,
          FIELD_TIMESTAMP: referenceDate
              .subtract(const Duration(days: 30))
              .millisecondsSinceEpoch,
        },
      ]);
      controllers[PATH_USER_TYPES]!.add([
        {FIELD_DOCUMENT_ID: USER_TYPE_FULL},
        {FIELD_DOCUMENT_ID: USER_TYPE_STUDENT},
        {FIELD_DOCUMENT_ID: USER_TYPE_ELDERLY},
      ]);

      final result = await resultFuture;
      final snapshot = result.fold(
        (failure) => fail('Unexpected failure: ${failure.messageKey}'),
        (value) => value,
      );

      expect(snapshot.totalUserCount, 1);
      expect(snapshot.totalWalletBalance, 125);
      expect(snapshot.totalRevenue, 30);
      expect(snapshot.weeklyMetrics.todayRideCount, 2);
      expect(snapshot.users, hasLength(1));
      expect(snapshot.users.single.id, 'user-id');
      expect(snapshot.users.single.role, USER_ROLE_PASSENGER);
      expect(snapshot.users.single.userTypeId, USER_TYPE_FULL);
      expect(snapshot.userTypes, hasLength(3));
    },
  );

  test('rejects unknown user type without writing Firestore', () async {
    final result = await repository.updateUserType('user-id', 'unknown-id');

    expect(result.isLeft(), isTrue);
    verifyNever(
      () => firestoreService.updateDocument(
        any(),
        any(),
        any(),
        stampUpdatedAt: any(named: 'stampUpdatedAt'),
      ),
    );
  });

  test('updates a supported user type through Firestore service', () async {
    when(
      () => firestoreService.updateDocument(
        any(),
        any(),
        any(),
        stampUpdatedAt: any(named: 'stampUpdatedAt'),
      ),
    ).thenAnswer((_) async {});

    final result = await repository.updateUserType(
      'user-id',
      USER_TYPE_STUDENT,
    );

    expect(result.isRight(), isTrue);
    verify(
      () => firestoreService.updateDocument(PATH_USERS, 'user-id', {
        FIELD_USER_TYPE: USER_TYPE_STUDENT,
      }, stampUpdatedAt: true),
    ).called(1);
  });
}
