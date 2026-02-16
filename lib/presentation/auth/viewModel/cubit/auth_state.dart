part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;

  const factory AuthState.anonymous({
    required String userId,
  }) = AuthAnonymous;

  const factory AuthState.authenticated({
    required String userId,
    required String email,
    String? displayName,
    String? photoUrl,
  }) = AuthAuthenticated;

  const factory AuthState.signingIn() = AuthSigningIn;

  const factory AuthState.error({
    required String message,
  }) = AuthError;

  const factory AuthState.signingOut() = AuthSigningOut;
}