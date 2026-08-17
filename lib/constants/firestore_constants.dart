class FirestorePaths {
  const FirestorePaths._();

  static const String users = 'users';
  static const String cards = 'cards';
  static const String tickets = 'tickets';
  static const String passTickets = 'pass_tickets';
  static const String metrics = 'metrics';
  static const String wallets = 'wallets';
  static const String transactions = 'transactions';
  static const String busLines = 'bus_lines';
  static const String userTypes = 'user_types';

  static String userDoc(String userId) => '$users/$userId';
  static String cardDoc(String cardId) => '$cards/$cardId';
  static String ticketDoc(String ticketId) => '$tickets/$ticketId';
  static String passTicketDoc(String ticketId) => '$passTickets/$ticketId';
  static String walletDoc(String userId) => '$wallets/$userId';
  static String transactionDoc(String transactionId) =>
      '$transactions/$transactionId';
}

class FirestoreFields {
  const FirestoreFields._();

  // User fields
  static const String displayName = 'displayName';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String role = 'role';
  static const String userType = 'userType';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';

  // Card fields
  static const String ownerId = 'ownerId';
  static const String balance = 'balance';
  static const String userId = 'userId';

  // Ticket fields
  static const String cardId = 'cardId';
  static const String amount = 'amount';
  static const String status = 'status';
  static const String validatorId = 'validatorId';
  static const String issuedAt = 'issuedAt';
  static const String expiresAt = 'expiresAt';
  static const String validatedAt = 'validatedAt';
  static const String timestamp = 'timestamp';
  static const String type = 'type';
  static const String name = 'name';
}

class UserTypeIds {
  const UserTypeIds._();

  static const String full = 'QKGkuQo7ifAGU4mVn0bx';
  static const String student = '3mg1KVLvucJvCST6Uj8Y';
  static const String elderly = 'VrkE28U4RtDA88R3wIw5';

  static const Map<String, String> fallbackLabels = {
    full: 'Tam',
    student: 'Öğrenci',
    elderly: 'Yaşlı',
  };
}
