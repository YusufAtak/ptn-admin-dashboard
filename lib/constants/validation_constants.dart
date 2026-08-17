class ValidationConstants {
  const ValidationConstants._();

  // QR Payload Keys
  static const String keyType = 'type';
  static const String keyUserId = 'userId';
  static const String keyTicketId = 'ticketId';
  
  // Values
  static const String valCard = 'card';
  static const String valTicket = 'ticket';
  static const String valStudent = 'student';
  static const String valElderly = 'elderly';
  
  // Error Keys
  static const String errInvalidQr = 'invalid_qr';
  static const String errQrExpired = 'qr_expired';
  static const String errUserNotFound = 'user_not_found';
  static const String errInvalidType = 'invalid_type';
  
  // Audio Assets
  static const String soundSuccess = 'sounds/success.mp3';
  static const String soundError = 'sounds/error.mp3';
}
