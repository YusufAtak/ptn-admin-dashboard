import 'package:flutter_test/flutter_test.dart';
import 'package:ptn_admin_dashboard/presentation/auth_error_message.dart';

void main() {
  test('does not display an error when there is no active session', () {
    expect(authErrorText('auth.not_logged_in'), isNull);
    expect(authErrorText(null), isNull);
  });

  test('maps invalid credentials to a user friendly message', () {
    expect(
      authErrorText('auth.invalid_credentials'),
      'E-posta veya şifre hatalı.',
    );
  });

  test('does not expose internal error keys', () {
    final message = authErrorText('auth.firebase_error');

    expect(message, isNot(contains('auth.')));
  });
}
