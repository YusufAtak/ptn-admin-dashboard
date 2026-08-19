// ignore_for_file: constant_identifier_names

// --- FIRESTORE PATHS ---
const String PATH_USERS = 'users';
const String PATH_CARDS = 'cards';
const String PATH_TICKETS = 'tickets';
const String PATH_PASS_TICKETS = 'pass_tickets';
const String PATH_METRICS = 'metrics';
const String PATH_WALLETS = 'wallets';
const String PATH_TRANSACTIONS = 'transactions';
const String PATH_BUS_LINES = 'bus_lines';
const String PATH_USER_TYPES = 'user_types';

String userDocPath(String userId) => '$PATH_USERS/$userId';
String cardDocPath(String cardId) => '$PATH_CARDS/$cardId';
String ticketDocPath(String ticketId) => '$PATH_TICKETS/$ticketId';
String passTicketDocPath(String ticketId) => '$PATH_PASS_TICKETS/$ticketId';
String walletDocPath(String userId) => '$PATH_WALLETS/$userId';
String transactionDocPath(String transactionId) =>
    '$PATH_TRANSACTIONS/$transactionId';

// --- FIRESTORE FIELDS ---
const String FIELD_DOCUMENT_ID = 'id';
const String FIELD_DISPLAY_NAME = 'displayName';
const String FIELD_FIRST_NAME = 'firstName';
const String FIELD_LAST_NAME = 'lastName';
const String FIELD_EMAIL = 'email';
const String FIELD_ROLE = 'role';
const String FIELD_USER_TYPE = 'userType';
const String FIELD_PHOTO_URL = 'photoUrl';
const String FIELD_DATE_OF_BIRTH = 'dateOfBirth';
const String FIELD_CREATED_AT = 'createdAt';
const String FIELD_UPDATED_AT = 'updatedAt';
const String FIELD_OWNER_ID = 'ownerId';
const String FIELD_BALANCE = 'balance';
const String FIELD_CARD_ID = 'cardId';
const String FIELD_AMOUNT = 'amount';
const String FIELD_STATUS = 'status';
const String FIELD_VALIDATOR_ID = 'validatorId';
const String FIELD_ISSUED_AT = 'issuedAt';
const String FIELD_EXPIRES_AT = 'expiresAt';
const String FIELD_VALIDATED_AT = 'validatedAt';
const String FIELD_USER_ID = 'userId';
const String FIELD_IS_ACTIVE = 'isActive';
const String FIELD_REMAINING_RIDES = 'remainingRides';
const String FIELD_TIMESTAMP = 'timestamp';
const String FIELD_TYPE = 'type';
const String FIELD_NAME = 'name';

// --- USER TYPES ---
const String USER_TYPE_FULL = 'QKGkuQo7ifAGU4mVn0bx';
const String USER_TYPE_STUDENT = '3mg1KVLvucJvCST6Uj8Y';
const String USER_TYPE_ELDERLY = 'VrkE28U4RtDA88R3wIw5';

const Map<String, String> USER_TYPE_FALLBACK_LABELS = {
  USER_TYPE_FULL: 'Tam',
  USER_TYPE_STUDENT: 'Öğrenci',
  USER_TYPE_ELDERLY: 'Yaşlı',
};

// --- USER ROLES ---
const String USER_ROLE_ADMIN = 'admin';
const String USER_ROLE_PASSENGER = 'passenger';
const String USER_ROLE_VALIDATOR = 'validator';

// --- TRANSACTION TYPES ---
const String TRANSACTION_TYPE_SPEND = 'spend';
const String TRANSACTION_TYPE_TICKET_USE = 'ticket_use';
const List<String> RIDE_TRANSACTION_TYPES = [
  TRANSACTION_TYPE_SPEND,
  TRANSACTION_TYPE_TICKET_USE,
];
