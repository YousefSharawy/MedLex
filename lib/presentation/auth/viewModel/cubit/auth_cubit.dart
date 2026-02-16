import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transly/domain/repository.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final Repository _repository;

  AuthCubit(this._repository) : super(const AuthState.initial());

  // ═══════════════════════════════════════════════════════════
  // INITIALIZATION
  // ═══════════════════════════════════════════════════════════

  Future<void> initialize() async {
    final result = await _repository.initializeAuth();

    result.fold(
      (failture) => _safeEmit(AuthState.error(message: failture.message)),
      (status) {
        if (status.isAuthenticated) {
          _safeEmit(AuthState.authenticated(
            userId: status.id,
            email: status.email!,
            displayName: status.displayName,
            photoUrl: status.photoUrl,
          ));
          _repository.syncFavorites();
        } else {
          _safeEmit(AuthState.anonymous(userId: status.id));
        }
      },
    );
  }

  // ═══════════════════════════════════════════════════════════
  // GOOGLE SIGN-IN
  // ═══════════════════════════════════════════════════════════

  Future<void> signInWithGoogle() async {
    _safeEmit(const AuthState.signingIn());

    final result = await _repository.signInWithGoogle();

    result.fold(
      (failture) {
        if (failture.message.contains('cancelled')) {
          final status = _repository.currentAuthStatus;
          _safeEmit(AuthState.anonymous(userId: status.id));
        } else {
          _safeEmit(AuthState.error(message: failture.message));
        }
      },
      (status) {
        _safeEmit(AuthState.authenticated(
          userId: status.id,
          email: status.email!,
          displayName: status.displayName,
          photoUrl: status.photoUrl,
        ));
      },
    );
  }

  // ═══════════════════════════════════════════════════════════
  // SIGN OUT
  // ═══════════════════════════════════════════════════════════

  Future<void> signOut() async {
    _safeEmit(const AuthState.signingOut());

    final result = await _repository.signOut();

    result.fold(
      (failture) => _safeEmit(AuthState.error(message: failture.message)),
      (_) {
        final status = _repository.currentAuthStatus;
        _safeEmit(AuthState.anonymous(userId: status.id));
      },
    );
  }

  // ═══════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════

  bool get isAuthenticated => state is AuthAuthenticated;
bool get isAnonymous => state is! AuthAuthenticated;

  String? get userId {
    final s = state;
    if (s is AuthAuthenticated) return s.userId;
    if (s is AuthAnonymous) return s.userId;
    return null;
  }

  void _safeEmit(AuthState state) {
    if (!isClosed) emit(state);
  }
}