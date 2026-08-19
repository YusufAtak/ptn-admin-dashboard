import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/di/providers.dart';
import 'auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    Future.microtask(checkStatus);
    return const AuthState.initial();
  }

  Future<void> checkStatus() async {
    state = const AuthState.loading();
    final result = await ref.read(checkAdminStatusUseCaseProvider)();
    state = result.fold(
      (failure) => AuthState.unauthenticated(
        messageKey: failure.messageKey == 'auth.not_logged_in'
            ? null
            : failure.messageKey,
      ),
      (_) => const AuthState.authenticated(),
    );
  }

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      state = const AuthState.unauthenticated(
        messageKey: 'auth.required_fields',
      );
      return;
    }

    state = const AuthState.loading();
    final result = await ref.read(loginAdminUseCaseProvider)(
      email.trim(),
      password,
    );
    state = result.fold(
      (failure) => AuthState.unauthenticated(messageKey: failure.messageKey),
      (_) => const AuthState.authenticated(),
    );
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    final result = await ref.read(logoutUseCaseProvider)();
    state = result.fold(
      (failure) => AuthState.unauthenticated(messageKey: failure.messageKey),
      (_) => const AuthState.unauthenticated(),
    );
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
