// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )
    loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )?
    loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )?
    loaded,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeInitial value) initial,
    required TResult Function(HomeLoaded value) loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeInitial value)? initial,
    TResult? Function(HomeLoaded value)? loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeInitial value)? initial,
    TResult Function(HomeLoaded value)? loaded,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HomeInitialImplCopyWith<$Res> {
  factory _$$HomeInitialImplCopyWith(
    _$HomeInitialImpl value,
    $Res Function(_$HomeInitialImpl) then,
  ) = __$$HomeInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeInitialImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeInitialImpl>
    implements _$$HomeInitialImplCopyWith<$Res> {
  __$$HomeInitialImplCopyWithImpl(
    _$HomeInitialImpl _value,
    $Res Function(_$HomeInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HomeInitialImpl implements _HomeInitial {
  const _$HomeInitialImpl();

  @override
  String toString() {
    return 'HomeState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HomeInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )
    loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )?
    loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )?
    loaded,
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
    required TResult Function(_HomeInitial value) initial,
    required TResult Function(HomeLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeInitial value)? initial,
    TResult? Function(HomeLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeInitial value)? initial,
    TResult Function(HomeLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _HomeInitial implements HomeState {
  const factory _HomeInitial() = _$HomeInitialImpl;
}

/// @nodoc
abstract class _$$HomeLoadedImplCopyWith<$Res> {
  factory _$$HomeLoadedImplCopyWith(
    _$HomeLoadedImpl value,
    $Res Function(_$HomeLoadedImpl) then,
  ) = __$$HomeLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    TermModel? dailyTerm,
    bool isLoading,
    String? errorMessage,
    List<TermModel> popularTerms,
    List<TermModel> trendingTerms,
  });

  $TermModelCopyWith<$Res>? get dailyTerm;
}

/// @nodoc
class __$$HomeLoadedImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeLoadedImpl>
    implements _$$HomeLoadedImplCopyWith<$Res> {
  __$$HomeLoadedImplCopyWithImpl(
    _$HomeLoadedImpl _value,
    $Res Function(_$HomeLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyTerm = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? popularTerms = null,
    Object? trendingTerms = null,
  }) {
    return _then(
      _$HomeLoadedImpl(
        dailyTerm:
            freezed == dailyTerm
                ? _value.dailyTerm
                : dailyTerm // ignore: cast_nullable_to_non_nullable
                    as TermModel?,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        popularTerms:
            null == popularTerms
                ? _value._popularTerms
                : popularTerms // ignore: cast_nullable_to_non_nullable
                    as List<TermModel>,
        trendingTerms:
            null == trendingTerms
                ? _value._trendingTerms
                : trendingTerms // ignore: cast_nullable_to_non_nullable
                    as List<TermModel>,
      ),
    );
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TermModelCopyWith<$Res>? get dailyTerm {
    if (_value.dailyTerm == null) {
      return null;
    }

    return $TermModelCopyWith<$Res>(_value.dailyTerm!, (value) {
      return _then(_value.copyWith(dailyTerm: value));
    });
  }
}

/// @nodoc

class _$HomeLoadedImpl implements HomeLoaded {
  const _$HomeLoadedImpl({
    this.dailyTerm,
    this.isLoading = false,
    this.errorMessage,
    final List<TermModel> popularTerms = const [],
    final List<TermModel> trendingTerms = const [],
  }) : _popularTerms = popularTerms,
       _trendingTerms = trendingTerms;

  @override
  final TermModel? dailyTerm;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  final List<TermModel> _popularTerms;
  @override
  @JsonKey()
  List<TermModel> get popularTerms {
    if (_popularTerms is EqualUnmodifiableListView) return _popularTerms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_popularTerms);
  }

  final List<TermModel> _trendingTerms;
  @override
  @JsonKey()
  List<TermModel> get trendingTerms {
    if (_trendingTerms is EqualUnmodifiableListView) return _trendingTerms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trendingTerms);
  }

  @override
  String toString() {
    return 'HomeState.loaded(dailyTerm: $dailyTerm, isLoading: $isLoading, errorMessage: $errorMessage, popularTerms: $popularTerms, trendingTerms: $trendingTerms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeLoadedImpl &&
            (identical(other.dailyTerm, dailyTerm) ||
                other.dailyTerm == dailyTerm) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._popularTerms,
              _popularTerms,
            ) &&
            const DeepCollectionEquality().equals(
              other._trendingTerms,
              _trendingTerms,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    dailyTerm,
    isLoading,
    errorMessage,
    const DeepCollectionEquality().hash(_popularTerms),
    const DeepCollectionEquality().hash(_trendingTerms),
  );

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeLoadedImplCopyWith<_$HomeLoadedImpl> get copyWith =>
      __$$HomeLoadedImplCopyWithImpl<_$HomeLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )
    loaded,
  }) {
    return loaded(
      dailyTerm,
      isLoading,
      errorMessage,
      popularTerms,
      trendingTerms,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )?
    loaded,
  }) {
    return loaded?.call(
      dailyTerm,
      isLoading,
      errorMessage,
      popularTerms,
      trendingTerms,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      TermModel? dailyTerm,
      bool isLoading,
      String? errorMessage,
      List<TermModel> popularTerms,
      List<TermModel> trendingTerms,
    )?
    loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        dailyTerm,
        isLoading,
        errorMessage,
        popularTerms,
        trendingTerms,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeInitial value) initial,
    required TResult Function(HomeLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeInitial value)? initial,
    TResult? Function(HomeLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeInitial value)? initial,
    TResult Function(HomeLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class HomeLoaded implements HomeState {
  const factory HomeLoaded({
    final TermModel? dailyTerm,
    final bool isLoading,
    final String? errorMessage,
    final List<TermModel> popularTerms,
    final List<TermModel> trendingTerms,
  }) = _$HomeLoadedImpl;

  TermModel? get dailyTerm;
  bool get isLoading;
  String? get errorMessage;
  List<TermModel> get popularTerms;
  List<TermModel> get trendingTerms;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeLoadedImplCopyWith<_$HomeLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
