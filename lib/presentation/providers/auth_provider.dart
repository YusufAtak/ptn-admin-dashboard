import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/di/providers.dart';

part 'auth_provider.freezed.dart';

enum AuthStatus { initial, authenticating, authenticated, unauthenticated }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    String? errorMessage,
  }) = _AuthState;
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    Future.microtask(checkStatus);
    return const AuthState();
  }

  Future<void> checkStatus() async {
    state = state.copyWith(
      status: AuthStatus.authenticating,
      errorMessage: null,
    );
    final result = await ref.read(authRepositoryProvider).checkAdminStatus();

    result.fold(
      (failure) {
        state = AuthState(
          status: AuthStatus.unauthenticated,
          errorMessage: failure.messageKey == 'auth.not_logged_in'
              ? null
              : failure.messageKey,
        );
      },
      (_) {
        state = const AuthState(status: AuthStatus.authenticated);
      },
    );
  }

  Future<bool> login(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      state = const AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: 'auth.required_fields',
      );
      return false;
    }

    state = state.copyWith(
      status: AuthStatus.authenticating,
      errorMessage: null,
    );
    final result = await ref
        .read(authRepositoryProvider)
        .loginAdmin(email.trim(), password);

    return result.fold(
      (failure) {
        state = AuthState(
          status: AuthStatus.unauthenticated,
          errorMessage: failure.messageKey,
        );
        return false;
      },
      (_) {
        state = const AuthState(status: AuthStatus.authenticated);
        return true;
      },
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
