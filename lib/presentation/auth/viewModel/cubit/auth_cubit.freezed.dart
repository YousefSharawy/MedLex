// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) anonymous,
    required TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )
    authenticated,
    required TResult Function() signingIn,
    required TResult Function(String message) error,
    required TResult Function() signingOut,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String userId)? anonymous,
    TResult? Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult? Function()? signingIn,
    TResult? Function(String message)? error,
    TResult? Function()? signingOut,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? anonymous,
    TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult Function()? signingIn,
    TResult Function(String message)? error,
    TResult Function()? signingOut,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthAnonymous value) anonymous,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthSigningIn value) signingIn,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthSigningOut value) signingOut,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthAnonymous value)? anonymous,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthSigningIn value)? signingIn,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthSigningOut value)? signingOut,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthAnonymous value)? anonymous,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthSigningIn value)? signingIn,
    TResult Function(AuthError value)? error,
    TResult Function(AuthSigningOut value)? signingOut,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthInitialImplCopyWith<$Res> {
  factory _$$AuthInitialImplCopyWith(
    _$AuthInitialImpl value,
    $Res Function(_$AuthInitialImpl) then,
  ) = __$$AuthInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthInitialImpl>
    implements _$$AuthInitialImplCopyWith<$Res> {
  __$$AuthInitialImplCopyWithImpl(
    _$AuthInitialImpl _value,
    $Res Function(_$AuthInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthInitialImpl implements AuthInitial {
  const _$AuthInitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) anonymous,
    required TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )
    authenticated,
    required TResult Function() signingIn,
    required TResult Function(String message) error,
    required TResult Function() signingOut,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String userId)? anonymous,
    TResult? Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult? Function()? signingIn,
    TResult? Function(String message)? error,
    TResult? Function()? signingOut,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? anonymous,
    TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult Function()? signingIn,
    TResult Function(String message)? error,
    TResult Function()? signingOut,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthAnonymous value) anonymous,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthSigningIn value) signingIn,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthSigningOut value) signingOut,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthAnonymous value)? anonymous,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthSigningIn value)? signingIn,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthSigningOut value)? signingOut,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthAnonymous value)? anonymous,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthSigningIn value)? signingIn,
    TResult Function(AuthError value)? error,
    TResult Function(AuthSigningOut value)? signingOut,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthInitial implements AuthState {
  const factory AuthInitial() = _$AuthInitialImpl;
}

/// @nodoc
abstract class _$$AuthAnonymousImplCopyWith<$Res> {
  factory _$$AuthAnonymousImplCopyWith(
    _$AuthAnonymousImpl value,
    $Res Function(_$AuthAnonymousImpl) then,
  ) = __$$AuthAnonymousImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$AuthAnonymousImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthAnonymousImpl>
    implements _$$AuthAnonymousImplCopyWith<$Res> {
  __$$AuthAnonymousImplCopyWithImpl(
    _$AuthAnonymousImpl _value,
    $Res Function(_$AuthAnonymousImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$AuthAnonymousImpl(
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthAnonymousImpl implements AuthAnonymous {
  const _$AuthAnonymousImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'AuthState.anonymous(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAnonymousImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAnonymousImplCopyWith<_$AuthAnonymousImpl> get copyWith =>
      __$$AuthAnonymousImplCopyWithImpl<_$AuthAnonymousImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) anonymous,
    required TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )
    authenticated,
    required TResult Function() signingIn,
    required TResult Function(String message) error,
    required TResult Function() signingOut,
  }) {
    return anonymous(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String userId)? anonymous,
    TResult? Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult? Function()? signingIn,
    TResult? Function(String message)? error,
    TResult? Function()? signingOut,
  }) {
    return anonymous?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? anonymous,
    TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult Function()? signingIn,
    TResult Function(String message)? error,
    TResult Function()? signingOut,
    required TResult orElse(),
  }) {
    if (anonymous != null) {
      return anonymous(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthAnonymous value) anonymous,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthSigningIn value) signingIn,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthSigningOut value) signingOut,
  }) {
    return anonymous(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthAnonymous value)? anonymous,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthSigningIn value)? signingIn,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthSigningOut value)? signingOut,
  }) {
    return anonymous?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthAnonymous value)? anonymous,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthSigningIn value)? signingIn,
    TResult Function(AuthError value)? error,
    TResult Function(AuthSigningOut value)? signingOut,
    required TResult orElse(),
  }) {
    if (anonymous != null) {
      return anonymous(this);
    }
    return orElse();
  }
}

abstract class AuthAnonymous implements AuthState {
  const factory AuthAnonymous({required final String userId}) =
      _$AuthAnonymousImpl;

  String get userId;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthAnonymousImplCopyWith<_$AuthAnonymousImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthAuthenticatedImplCopyWith(
    _$AuthAuthenticatedImpl value,
    $Res Function(_$AuthAuthenticatedImpl) then,
  ) = __$$AuthAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String userId,
    String email,
    String? displayName,
    String? photoUrl,
  });
}

/// @nodoc
class __$$AuthAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthAuthenticatedImpl>
    implements _$$AuthAuthenticatedImplCopyWith<$Res> {
  __$$AuthAuthenticatedImplCopyWithImpl(
    _$AuthAuthenticatedImpl _value,
    $Res Function(_$AuthAuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _$AuthAuthenticatedImpl(
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        displayName:
            freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                    as String?,
        photoUrl:
            freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthAuthenticatedImpl implements AuthAuthenticated {
  const _$AuthAuthenticatedImpl({
    required this.userId,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  @override
  final String userId;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;

  @override
  String toString() {
    return 'AuthState.authenticated(userId: $userId, email: $email, displayName: $displayName, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAuthenticatedImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, email, displayName, photoUrl);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      __$$AuthAuthenticatedImplCopyWithImpl<_$AuthAuthenticatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) anonymous,
    required TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )
    authenticated,
    required TResult Function() signingIn,
    required TResult Function(String message) error,
    required TResult Function() signingOut,
  }) {
    return authenticated(userId, email, displayName, photoUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String userId)? anonymous,
    TResult? Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult? Function()? signingIn,
    TResult? Function(String message)? error,
    TResult? Function()? signingOut,
  }) {
    return authenticated?.call(userId, email, displayName, photoUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? anonymous,
    TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult Function()? signingIn,
    TResult Function(String message)? error,
    TResult Function()? signingOut,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(userId, email, displayName, photoUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthAnonymous value) anonymous,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthSigningIn value) signingIn,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthSigningOut value) signingOut,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthAnonymous value)? anonymous,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthSigningIn value)? signingIn,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthSigningOut value)? signingOut,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthAnonymous value)? anonymous,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthSigningIn value)? signingIn,
    TResult Function(AuthError value)? error,
    TResult Function(AuthSigningOut value)? signingOut,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthAuthenticated implements AuthState {
  const factory AuthAuthenticated({
    required final String userId,
    required final String email,
    final String? displayName,
    final String? photoUrl,
  }) = _$AuthAuthenticatedImpl;

  String get userId;
  String get email;
  String? get displayName;
  String? get photoUrl;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSigningInImplCopyWith<$Res> {
  factory _$$AuthSigningInImplCopyWith(
    _$AuthSigningInImpl value,
    $Res Function(_$AuthSigningInImpl) then,
  ) = __$$AuthSigningInImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthSigningInImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthSigningInImpl>
    implements _$$AuthSigningInImplCopyWith<$Res> {
  __$$AuthSigningInImplCopyWithImpl(
    _$AuthSigningInImpl _value,
    $Res Function(_$AuthSigningInImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthSigningInImpl implements AuthSigningIn {
  const _$AuthSigningInImpl();

  @override
  String toString() {
    return 'AuthState.signingIn()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthSigningInImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) anonymous,
    required TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )
    authenticated,
    required TResult Function() signingIn,
    required TResult Function(String message) error,
    required TResult Function() signingOut,
  }) {
    return signingIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String userId)? anonymous,
    TResult? Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult? Function()? signingIn,
    TResult? Function(String message)? error,
    TResult? Function()? signingOut,
  }) {
    return signingIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? anonymous,
    TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult Function()? signingIn,
    TResult Function(String message)? error,
    TResult Function()? signingOut,
    required TResult orElse(),
  }) {
    if (signingIn != null) {
      return signingIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthAnonymous value) anonymous,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthSigningIn value) signingIn,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthSigningOut value) signingOut,
  }) {
    return signingIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthAnonymous value)? anonymous,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthSigningIn value)? signingIn,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthSigningOut value)? signingOut,
  }) {
    return signingIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthAnonymous value)? anonymous,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthSigningIn value)? signingIn,
    TResult Function(AuthError value)? error,
    TResult Function(AuthSigningOut value)? signingOut,
    required TResult orElse(),
  }) {
    if (signingIn != null) {
      return signingIn(this);
    }
    return orElse();
  }
}

abstract class AuthSigningIn implements AuthState {
  const factory AuthSigningIn() = _$AuthSigningInImpl;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
    _$AuthErrorImpl value,
    $Res Function(_$AuthErrorImpl) then,
  ) = __$$AuthErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
    _$AuthErrorImpl _value,
    $Res Function(_$AuthErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthErrorImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorImpl implements AuthError {
  const _$AuthErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) anonymous,
    required TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )
    authenticated,
    required TResult Function() signingIn,
    required TResult Function(String message) error,
    required TResult Function() signingOut,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String userId)? anonymous,
    TResult? Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult? Function()? signingIn,
    TResult? Function(String message)? error,
    TResult? Function()? signingOut,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? anonymous,
    TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult Function()? signingIn,
    TResult Function(String message)? error,
    TResult Function()? signingOut,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthAnonymous value) anonymous,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthSigningIn value) signingIn,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthSigningOut value) signingOut,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthAnonymous value)? anonymous,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthSigningIn value)? signingIn,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthSigningOut value)? signingOut,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthAnonymous value)? anonymous,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthSigningIn value)? signingIn,
    TResult Function(AuthError value)? error,
    TResult Function(AuthSigningOut value)? signingOut,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError({required final String message}) = _$AuthErrorImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSigningOutImplCopyWith<$Res> {
  factory _$$AuthSigningOutImplCopyWith(
    _$AuthSigningOutImpl value,
    $Res Function(_$AuthSigningOutImpl) then,
  ) = __$$AuthSigningOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthSigningOutImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthSigningOutImpl>
    implements _$$AuthSigningOutImplCopyWith<$Res> {
  __$$AuthSigningOutImplCopyWithImpl(
    _$AuthSigningOutImpl _value,
    $Res Function(_$AuthSigningOutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthSigningOutImpl implements AuthSigningOut {
  const _$AuthSigningOutImpl();

  @override
  String toString() {
    return 'AuthState.signingOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthSigningOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) anonymous,
    required TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )
    authenticated,
    required TResult Function() signingIn,
    required TResult Function(String message) error,
    required TResult Function() signingOut,
  }) {
    return signingOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String userId)? anonymous,
    TResult? Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult? Function()? signingIn,
    TResult? Function(String message)? error,
    TResult? Function()? signingOut,
  }) {
    return signingOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? anonymous,
    TResult Function(
      String userId,
      String email,
      String? displayName,
      String? photoUrl,
    )?
    authenticated,
    TResult Function()? signingIn,
    TResult Function(String message)? error,
    TResult Function()? signingOut,
    required TResult orElse(),
  }) {
    if (signingOut != null) {
      return signingOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthAnonymous value) anonymous,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthSigningIn value) signingIn,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthSigningOut value) signingOut,
  }) {
    return signingOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthAnonymous value)? anonymous,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthSigningIn value)? signingIn,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthSigningOut value)? signingOut,
  }) {
    return signingOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthAnonymous value)? anonymous,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthSigningIn value)? signingIn,
    TResult Function(AuthError value)? error,
    TResult Function(AuthSigningOut value)? signingOut,
    required TResult orElse(),
  }) {
    if (signingOut != null) {
      return signingOut(this);
    }
    return orElse();
  }
}

abstract class AuthSigningOut implements AuthState {
  const factory AuthSigningOut() = _$AuthSigningOutImpl;
}
