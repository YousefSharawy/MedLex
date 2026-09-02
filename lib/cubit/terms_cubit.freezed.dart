// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'terms_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TermsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() allTermsLoading,
    required TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )
    allTermsLoaded,
    required TResult Function(String message) allTermsError,
    required TResult Function() termsByCategoryLoading,
    required TResult Function(List<TermModel> terms) termsByCategoryLoaded,
    required TResult Function(String message) termsByCategoryError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? allTermsLoading,
    TResult? Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult? Function(String message)? allTermsError,
    TResult? Function()? termsByCategoryLoading,
    TResult? Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult? Function(String message)? termsByCategoryError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? allTermsLoading,
    TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult Function(String message)? allTermsError,
    TResult Function()? termsByCategoryLoading,
    TResult Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult Function(String message)? termsByCategoryError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TermsInitial value) initial,
    required TResult Function(AllTermsLoading value) allTermsLoading,
    required TResult Function(AllTermsLoaded value) allTermsLoaded,
    required TResult Function(AllTermsError value) allTermsError,
    required TResult Function(TermsByCategoryLoading value)
    termsByCategoryLoading,
    required TResult Function(TermsByCategoryLoaded value)
    termsByCategoryLoaded,
    required TResult Function(TermsByCategoryError value) termsByCategoryError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TermsInitial value)? initial,
    TResult? Function(AllTermsLoading value)? allTermsLoading,
    TResult? Function(AllTermsLoaded value)? allTermsLoaded,
    TResult? Function(AllTermsError value)? allTermsError,
    TResult? Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult? Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult? Function(TermsByCategoryError value)? termsByCategoryError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TermsInitial value)? initial,
    TResult Function(AllTermsLoading value)? allTermsLoading,
    TResult Function(AllTermsLoaded value)? allTermsLoaded,
    TResult Function(AllTermsError value)? allTermsError,
    TResult Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult Function(TermsByCategoryError value)? termsByCategoryError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermsStateCopyWith<$Res> {
  factory $TermsStateCopyWith(
    TermsState value,
    $Res Function(TermsState) then,
  ) = _$TermsStateCopyWithImpl<$Res, TermsState>;
}

/// @nodoc
class _$TermsStateCopyWithImpl<$Res, $Val extends TermsState>
    implements $TermsStateCopyWith<$Res> {
  _$TermsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TermsInitialImplCopyWith<$Res> {
  factory _$$TermsInitialImplCopyWith(
    _$TermsInitialImpl value,
    $Res Function(_$TermsInitialImpl) then,
  ) = __$$TermsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TermsInitialImplCopyWithImpl<$Res>
    extends _$TermsStateCopyWithImpl<$Res, _$TermsInitialImpl>
    implements _$$TermsInitialImplCopyWith<$Res> {
  __$$TermsInitialImplCopyWithImpl(
    _$TermsInitialImpl _value,
    $Res Function(_$TermsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TermsInitialImpl implements _TermsInitial {
  const _$TermsInitialImpl();

  @override
  String toString() {
    return 'TermsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TermsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() allTermsLoading,
    required TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )
    allTermsLoaded,
    required TResult Function(String message) allTermsError,
    required TResult Function() termsByCategoryLoading,
    required TResult Function(List<TermModel> terms) termsByCategoryLoaded,
    required TResult Function(String message) termsByCategoryError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? allTermsLoading,
    TResult? Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult? Function(String message)? allTermsError,
    TResult? Function()? termsByCategoryLoading,
    TResult? Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult? Function(String message)? termsByCategoryError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? allTermsLoading,
    TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult Function(String message)? allTermsError,
    TResult Function()? termsByCategoryLoading,
    TResult Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult Function(String message)? termsByCategoryError,
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
    required TResult Function(_TermsInitial value) initial,
    required TResult Function(AllTermsLoading value) allTermsLoading,
    required TResult Function(AllTermsLoaded value) allTermsLoaded,
    required TResult Function(AllTermsError value) allTermsError,
    required TResult Function(TermsByCategoryLoading value)
    termsByCategoryLoading,
    required TResult Function(TermsByCategoryLoaded value)
    termsByCategoryLoaded,
    required TResult Function(TermsByCategoryError value) termsByCategoryError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TermsInitial value)? initial,
    TResult? Function(AllTermsLoading value)? allTermsLoading,
    TResult? Function(AllTermsLoaded value)? allTermsLoaded,
    TResult? Function(AllTermsError value)? allTermsError,
    TResult? Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult? Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult? Function(TermsByCategoryError value)? termsByCategoryError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TermsInitial value)? initial,
    TResult Function(AllTermsLoading value)? allTermsLoading,
    TResult Function(AllTermsLoaded value)? allTermsLoaded,
    TResult Function(AllTermsError value)? allTermsError,
    TResult Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult Function(TermsByCategoryError value)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _TermsInitial implements TermsState {
  const factory _TermsInitial() = _$TermsInitialImpl;
}

/// @nodoc
abstract class _$$AllTermsLoadingImplCopyWith<$Res> {
  factory _$$AllTermsLoadingImplCopyWith(
    _$AllTermsLoadingImpl value,
    $Res Function(_$AllTermsLoadingImpl) then,
  ) = __$$AllTermsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllTermsLoadingImplCopyWithImpl<$Res>
    extends _$TermsStateCopyWithImpl<$Res, _$AllTermsLoadingImpl>
    implements _$$AllTermsLoadingImplCopyWith<$Res> {
  __$$AllTermsLoadingImplCopyWithImpl(
    _$AllTermsLoadingImpl _value,
    $Res Function(_$AllTermsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AllTermsLoadingImpl implements AllTermsLoading {
  const _$AllTermsLoadingImpl();

  @override
  String toString() {
    return 'TermsState.allTermsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AllTermsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() allTermsLoading,
    required TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )
    allTermsLoaded,
    required TResult Function(String message) allTermsError,
    required TResult Function() termsByCategoryLoading,
    required TResult Function(List<TermModel> terms) termsByCategoryLoaded,
    required TResult Function(String message) termsByCategoryError,
  }) {
    return allTermsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? allTermsLoading,
    TResult? Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult? Function(String message)? allTermsError,
    TResult? Function()? termsByCategoryLoading,
    TResult? Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult? Function(String message)? termsByCategoryError,
  }) {
    return allTermsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? allTermsLoading,
    TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult Function(String message)? allTermsError,
    TResult Function()? termsByCategoryLoading,
    TResult Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult Function(String message)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (allTermsLoading != null) {
      return allTermsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TermsInitial value) initial,
    required TResult Function(AllTermsLoading value) allTermsLoading,
    required TResult Function(AllTermsLoaded value) allTermsLoaded,
    required TResult Function(AllTermsError value) allTermsError,
    required TResult Function(TermsByCategoryLoading value)
    termsByCategoryLoading,
    required TResult Function(TermsByCategoryLoaded value)
    termsByCategoryLoaded,
    required TResult Function(TermsByCategoryError value) termsByCategoryError,
  }) {
    return allTermsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TermsInitial value)? initial,
    TResult? Function(AllTermsLoading value)? allTermsLoading,
    TResult? Function(AllTermsLoaded value)? allTermsLoaded,
    TResult? Function(AllTermsError value)? allTermsError,
    TResult? Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult? Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult? Function(TermsByCategoryError value)? termsByCategoryError,
  }) {
    return allTermsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TermsInitial value)? initial,
    TResult Function(AllTermsLoading value)? allTermsLoading,
    TResult Function(AllTermsLoaded value)? allTermsLoaded,
    TResult Function(AllTermsError value)? allTermsError,
    TResult Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult Function(TermsByCategoryError value)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (allTermsLoading != null) {
      return allTermsLoading(this);
    }
    return orElse();
  }
}

abstract class AllTermsLoading implements TermsState {
  const factory AllTermsLoading() = _$AllTermsLoadingImpl;
}

/// @nodoc
abstract class _$$AllTermsLoadedImplCopyWith<$Res> {
  factory _$$AllTermsLoadedImplCopyWith(
    _$AllTermsLoadedImpl value,
    $Res Function(_$AllTermsLoadedImpl) then,
  ) = __$$AllTermsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<TermModel> terms,
    bool hasMore,
    int currentPage,
    int totalCount,
    bool isLoadingMore,
    String? pendingLetter,
    String? letterJustLoaded,
    bool isLetterLoading,
    Map<String, List<TermModel>> groupedTerms,
  });
}

/// @nodoc
class __$$AllTermsLoadedImplCopyWithImpl<$Res>
    extends _$TermsStateCopyWithImpl<$Res, _$AllTermsLoadedImpl>
    implements _$$AllTermsLoadedImplCopyWith<$Res> {
  __$$AllTermsLoadedImplCopyWithImpl(
    _$AllTermsLoadedImpl _value,
    $Res Function(_$AllTermsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? terms = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? isLoadingMore = null,
    Object? pendingLetter = freezed,
    Object? letterJustLoaded = freezed,
    Object? isLetterLoading = null,
    Object? groupedTerms = null,
  }) {
    return _then(
      _$AllTermsLoadedImpl(
        terms:
            null == terms
                ? _value._terms
                : terms // ignore: cast_nullable_to_non_nullable
                    as List<TermModel>,
        hasMore:
            null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                    as bool,
        currentPage:
            null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int,
        totalCount:
            null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                    as int,
        isLoadingMore:
            null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                    as bool,
        pendingLetter:
            freezed == pendingLetter
                ? _value.pendingLetter
                : pendingLetter // ignore: cast_nullable_to_non_nullable
                    as String?,
        letterJustLoaded:
            freezed == letterJustLoaded
                ? _value.letterJustLoaded
                : letterJustLoaded // ignore: cast_nullable_to_non_nullable
                    as String?,
        isLetterLoading:
            null == isLetterLoading
                ? _value.isLetterLoading
                : isLetterLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        groupedTerms:
            null == groupedTerms
                ? _value._groupedTerms
                : groupedTerms // ignore: cast_nullable_to_non_nullable
                    as Map<String, List<TermModel>>,
      ),
    );
  }
}

/// @nodoc

class _$AllTermsLoadedImpl implements AllTermsLoaded {
  const _$AllTermsLoadedImpl({
    required final List<TermModel> terms,
    required this.hasMore,
    required this.currentPage,
    required this.totalCount,
    this.isLoadingMore = false,
    this.pendingLetter,
    this.letterJustLoaded,
    this.isLetterLoading = false,
    final Map<String, List<TermModel>> groupedTerms = const {},
  }) : _terms = terms,
       _groupedTerms = groupedTerms;

  final List<TermModel> _terms;
  @override
  List<TermModel> get terms {
    if (_terms is EqualUnmodifiableListView) return _terms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_terms);
  }

  @override
  final bool hasMore;
  @override
  final int currentPage;
  @override
  final int totalCount;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? pendingLetter;
  @override
  final String? letterJustLoaded;
  @override
  @JsonKey()
  final bool isLetterLoading;
  final Map<String, List<TermModel>> _groupedTerms;
  @override
  @JsonKey()
  Map<String, List<TermModel>> get groupedTerms {
    if (_groupedTerms is EqualUnmodifiableMapView) return _groupedTerms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_groupedTerms);
  }

  @override
  String toString() {
    return 'TermsState.allTermsLoaded(terms: $terms, hasMore: $hasMore, currentPage: $currentPage, totalCount: $totalCount, isLoadingMore: $isLoadingMore, pendingLetter: $pendingLetter, letterJustLoaded: $letterJustLoaded, isLetterLoading: $isLetterLoading, groupedTerms: $groupedTerms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllTermsLoadedImpl &&
            const DeepCollectionEquality().equals(other._terms, _terms) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.pendingLetter, pendingLetter) ||
                other.pendingLetter == pendingLetter) &&
            (identical(other.letterJustLoaded, letterJustLoaded) ||
                other.letterJustLoaded == letterJustLoaded) &&
            (identical(other.isLetterLoading, isLetterLoading) ||
                other.isLetterLoading == isLetterLoading) &&
            const DeepCollectionEquality().equals(
              other._groupedTerms,
              _groupedTerms,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_terms),
    hasMore,
    currentPage,
    totalCount,
    isLoadingMore,
    pendingLetter,
    letterJustLoaded,
    isLetterLoading,
    const DeepCollectionEquality().hash(_groupedTerms),
  );

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllTermsLoadedImplCopyWith<_$AllTermsLoadedImpl> get copyWith =>
      __$$AllTermsLoadedImplCopyWithImpl<_$AllTermsLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() allTermsLoading,
    required TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )
    allTermsLoaded,
    required TResult Function(String message) allTermsError,
    required TResult Function() termsByCategoryLoading,
    required TResult Function(List<TermModel> terms) termsByCategoryLoaded,
    required TResult Function(String message) termsByCategoryError,
  }) {
    return allTermsLoaded(
      terms,
      hasMore,
      currentPage,
      totalCount,
      isLoadingMore,
      pendingLetter,
      letterJustLoaded,
      isLetterLoading,
      groupedTerms,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? allTermsLoading,
    TResult? Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult? Function(String message)? allTermsError,
    TResult? Function()? termsByCategoryLoading,
    TResult? Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult? Function(String message)? termsByCategoryError,
  }) {
    return allTermsLoaded?.call(
      terms,
      hasMore,
      currentPage,
      totalCount,
      isLoadingMore,
      pendingLetter,
      letterJustLoaded,
      isLetterLoading,
      groupedTerms,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? allTermsLoading,
    TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult Function(String message)? allTermsError,
    TResult Function()? termsByCategoryLoading,
    TResult Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult Function(String message)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (allTermsLoaded != null) {
      return allTermsLoaded(
        terms,
        hasMore,
        currentPage,
        totalCount,
        isLoadingMore,
        pendingLetter,
        letterJustLoaded,
        isLetterLoading,
        groupedTerms,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TermsInitial value) initial,
    required TResult Function(AllTermsLoading value) allTermsLoading,
    required TResult Function(AllTermsLoaded value) allTermsLoaded,
    required TResult Function(AllTermsError value) allTermsError,
    required TResult Function(TermsByCategoryLoading value)
    termsByCategoryLoading,
    required TResult Function(TermsByCategoryLoaded value)
    termsByCategoryLoaded,
    required TResult Function(TermsByCategoryError value) termsByCategoryError,
  }) {
    return allTermsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TermsInitial value)? initial,
    TResult? Function(AllTermsLoading value)? allTermsLoading,
    TResult? Function(AllTermsLoaded value)? allTermsLoaded,
    TResult? Function(AllTermsError value)? allTermsError,
    TResult? Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult? Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult? Function(TermsByCategoryError value)? termsByCategoryError,
  }) {
    return allTermsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TermsInitial value)? initial,
    TResult Function(AllTermsLoading value)? allTermsLoading,
    TResult Function(AllTermsLoaded value)? allTermsLoaded,
    TResult Function(AllTermsError value)? allTermsError,
    TResult Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult Function(TermsByCategoryError value)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (allTermsLoaded != null) {
      return allTermsLoaded(this);
    }
    return orElse();
  }
}

abstract class AllTermsLoaded implements TermsState {
  const factory AllTermsLoaded({
    required final List<TermModel> terms,
    required final bool hasMore,
    required final int currentPage,
    required final int totalCount,
    final bool isLoadingMore,
    final String? pendingLetter,
    final String? letterJustLoaded,
    final bool isLetterLoading,
    final Map<String, List<TermModel>> groupedTerms,
  }) = _$AllTermsLoadedImpl;

  List<TermModel> get terms;
  bool get hasMore;
  int get currentPage;
  int get totalCount;
  bool get isLoadingMore;
  String? get pendingLetter;
  String? get letterJustLoaded;
  bool get isLetterLoading;
  Map<String, List<TermModel>> get groupedTerms;

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllTermsLoadedImplCopyWith<_$AllTermsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AllTermsErrorImplCopyWith<$Res> {
  factory _$$AllTermsErrorImplCopyWith(
    _$AllTermsErrorImpl value,
    $Res Function(_$AllTermsErrorImpl) then,
  ) = __$$AllTermsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AllTermsErrorImplCopyWithImpl<$Res>
    extends _$TermsStateCopyWithImpl<$Res, _$AllTermsErrorImpl>
    implements _$$AllTermsErrorImplCopyWith<$Res> {
  __$$AllTermsErrorImplCopyWithImpl(
    _$AllTermsErrorImpl _value,
    $Res Function(_$AllTermsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AllTermsErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$AllTermsErrorImpl implements AllTermsError {
  const _$AllTermsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TermsState.allTermsError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllTermsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllTermsErrorImplCopyWith<_$AllTermsErrorImpl> get copyWith =>
      __$$AllTermsErrorImplCopyWithImpl<_$AllTermsErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() allTermsLoading,
    required TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )
    allTermsLoaded,
    required TResult Function(String message) allTermsError,
    required TResult Function() termsByCategoryLoading,
    required TResult Function(List<TermModel> terms) termsByCategoryLoaded,
    required TResult Function(String message) termsByCategoryError,
  }) {
    return allTermsError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? allTermsLoading,
    TResult? Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult? Function(String message)? allTermsError,
    TResult? Function()? termsByCategoryLoading,
    TResult? Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult? Function(String message)? termsByCategoryError,
  }) {
    return allTermsError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? allTermsLoading,
    TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult Function(String message)? allTermsError,
    TResult Function()? termsByCategoryLoading,
    TResult Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult Function(String message)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (allTermsError != null) {
      return allTermsError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TermsInitial value) initial,
    required TResult Function(AllTermsLoading value) allTermsLoading,
    required TResult Function(AllTermsLoaded value) allTermsLoaded,
    required TResult Function(AllTermsError value) allTermsError,
    required TResult Function(TermsByCategoryLoading value)
    termsByCategoryLoading,
    required TResult Function(TermsByCategoryLoaded value)
    termsByCategoryLoaded,
    required TResult Function(TermsByCategoryError value) termsByCategoryError,
  }) {
    return allTermsError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TermsInitial value)? initial,
    TResult? Function(AllTermsLoading value)? allTermsLoading,
    TResult? Function(AllTermsLoaded value)? allTermsLoaded,
    TResult? Function(AllTermsError value)? allTermsError,
    TResult? Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult? Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult? Function(TermsByCategoryError value)? termsByCategoryError,
  }) {
    return allTermsError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TermsInitial value)? initial,
    TResult Function(AllTermsLoading value)? allTermsLoading,
    TResult Function(AllTermsLoaded value)? allTermsLoaded,
    TResult Function(AllTermsError value)? allTermsError,
    TResult Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult Function(TermsByCategoryError value)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (allTermsError != null) {
      return allTermsError(this);
    }
    return orElse();
  }
}

abstract class AllTermsError implements TermsState {
  const factory AllTermsError(final String message) = _$AllTermsErrorImpl;

  String get message;

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllTermsErrorImplCopyWith<_$AllTermsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TermsByCategoryLoadingImplCopyWith<$Res> {
  factory _$$TermsByCategoryLoadingImplCopyWith(
    _$TermsByCategoryLoadingImpl value,
    $Res Function(_$TermsByCategoryLoadingImpl) then,
  ) = __$$TermsByCategoryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TermsByCategoryLoadingImplCopyWithImpl<$Res>
    extends _$TermsStateCopyWithImpl<$Res, _$TermsByCategoryLoadingImpl>
    implements _$$TermsByCategoryLoadingImplCopyWith<$Res> {
  __$$TermsByCategoryLoadingImplCopyWithImpl(
    _$TermsByCategoryLoadingImpl _value,
    $Res Function(_$TermsByCategoryLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TermsByCategoryLoadingImpl implements TermsByCategoryLoading {
  const _$TermsByCategoryLoadingImpl();

  @override
  String toString() {
    return 'TermsState.termsByCategoryLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermsByCategoryLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() allTermsLoading,
    required TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )
    allTermsLoaded,
    required TResult Function(String message) allTermsError,
    required TResult Function() termsByCategoryLoading,
    required TResult Function(List<TermModel> terms) termsByCategoryLoaded,
    required TResult Function(String message) termsByCategoryError,
  }) {
    return termsByCategoryLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? allTermsLoading,
    TResult? Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult? Function(String message)? allTermsError,
    TResult? Function()? termsByCategoryLoading,
    TResult? Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult? Function(String message)? termsByCategoryError,
  }) {
    return termsByCategoryLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? allTermsLoading,
    TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult Function(String message)? allTermsError,
    TResult Function()? termsByCategoryLoading,
    TResult Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult Function(String message)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (termsByCategoryLoading != null) {
      return termsByCategoryLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TermsInitial value) initial,
    required TResult Function(AllTermsLoading value) allTermsLoading,
    required TResult Function(AllTermsLoaded value) allTermsLoaded,
    required TResult Function(AllTermsError value) allTermsError,
    required TResult Function(TermsByCategoryLoading value)
    termsByCategoryLoading,
    required TResult Function(TermsByCategoryLoaded value)
    termsByCategoryLoaded,
    required TResult Function(TermsByCategoryError value) termsByCategoryError,
  }) {
    return termsByCategoryLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TermsInitial value)? initial,
    TResult? Function(AllTermsLoading value)? allTermsLoading,
    TResult? Function(AllTermsLoaded value)? allTermsLoaded,
    TResult? Function(AllTermsError value)? allTermsError,
    TResult? Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult? Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult? Function(TermsByCategoryError value)? termsByCategoryError,
  }) {
    return termsByCategoryLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TermsInitial value)? initial,
    TResult Function(AllTermsLoading value)? allTermsLoading,
    TResult Function(AllTermsLoaded value)? allTermsLoaded,
    TResult Function(AllTermsError value)? allTermsError,
    TResult Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult Function(TermsByCategoryError value)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (termsByCategoryLoading != null) {
      return termsByCategoryLoading(this);
    }
    return orElse();
  }
}

abstract class TermsByCategoryLoading implements TermsState {
  const factory TermsByCategoryLoading() = _$TermsByCategoryLoadingImpl;
}

/// @nodoc
abstract class _$$TermsByCategoryLoadedImplCopyWith<$Res> {
  factory _$$TermsByCategoryLoadedImplCopyWith(
    _$TermsByCategoryLoadedImpl value,
    $Res Function(_$TermsByCategoryLoadedImpl) then,
  ) = __$$TermsByCategoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TermModel> terms});
}

/// @nodoc
class __$$TermsByCategoryLoadedImplCopyWithImpl<$Res>
    extends _$TermsStateCopyWithImpl<$Res, _$TermsByCategoryLoadedImpl>
    implements _$$TermsByCategoryLoadedImplCopyWith<$Res> {
  __$$TermsByCategoryLoadedImplCopyWithImpl(
    _$TermsByCategoryLoadedImpl _value,
    $Res Function(_$TermsByCategoryLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? terms = null}) {
    return _then(
      _$TermsByCategoryLoadedImpl(
        null == terms
            ? _value._terms
            : terms // ignore: cast_nullable_to_non_nullable
                as List<TermModel>,
      ),
    );
  }
}

/// @nodoc

class _$TermsByCategoryLoadedImpl implements TermsByCategoryLoaded {
  const _$TermsByCategoryLoadedImpl(final List<TermModel> terms)
    : _terms = terms;

  final List<TermModel> _terms;
  @override
  List<TermModel> get terms {
    if (_terms is EqualUnmodifiableListView) return _terms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_terms);
  }

  @override
  String toString() {
    return 'TermsState.termsByCategoryLoaded(terms: $terms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermsByCategoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._terms, _terms));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_terms));

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermsByCategoryLoadedImplCopyWith<_$TermsByCategoryLoadedImpl>
  get copyWith =>
      __$$TermsByCategoryLoadedImplCopyWithImpl<_$TermsByCategoryLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() allTermsLoading,
    required TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )
    allTermsLoaded,
    required TResult Function(String message) allTermsError,
    required TResult Function() termsByCategoryLoading,
    required TResult Function(List<TermModel> terms) termsByCategoryLoaded,
    required TResult Function(String message) termsByCategoryError,
  }) {
    return termsByCategoryLoaded(terms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? allTermsLoading,
    TResult? Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult? Function(String message)? allTermsError,
    TResult? Function()? termsByCategoryLoading,
    TResult? Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult? Function(String message)? termsByCategoryError,
  }) {
    return termsByCategoryLoaded?.call(terms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? allTermsLoading,
    TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult Function(String message)? allTermsError,
    TResult Function()? termsByCategoryLoading,
    TResult Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult Function(String message)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (termsByCategoryLoaded != null) {
      return termsByCategoryLoaded(terms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TermsInitial value) initial,
    required TResult Function(AllTermsLoading value) allTermsLoading,
    required TResult Function(AllTermsLoaded value) allTermsLoaded,
    required TResult Function(AllTermsError value) allTermsError,
    required TResult Function(TermsByCategoryLoading value)
    termsByCategoryLoading,
    required TResult Function(TermsByCategoryLoaded value)
    termsByCategoryLoaded,
    required TResult Function(TermsByCategoryError value) termsByCategoryError,
  }) {
    return termsByCategoryLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TermsInitial value)? initial,
    TResult? Function(AllTermsLoading value)? allTermsLoading,
    TResult? Function(AllTermsLoaded value)? allTermsLoaded,
    TResult? Function(AllTermsError value)? allTermsError,
    TResult? Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult? Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult? Function(TermsByCategoryError value)? termsByCategoryError,
  }) {
    return termsByCategoryLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TermsInitial value)? initial,
    TResult Function(AllTermsLoading value)? allTermsLoading,
    TResult Function(AllTermsLoaded value)? allTermsLoaded,
    TResult Function(AllTermsError value)? allTermsError,
    TResult Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult Function(TermsByCategoryError value)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (termsByCategoryLoaded != null) {
      return termsByCategoryLoaded(this);
    }
    return orElse();
  }
}

abstract class TermsByCategoryLoaded implements TermsState {
  const factory TermsByCategoryLoaded(final List<TermModel> terms) =
      _$TermsByCategoryLoadedImpl;

  List<TermModel> get terms;

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermsByCategoryLoadedImplCopyWith<_$TermsByCategoryLoadedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TermsByCategoryErrorImplCopyWith<$Res> {
  factory _$$TermsByCategoryErrorImplCopyWith(
    _$TermsByCategoryErrorImpl value,
    $Res Function(_$TermsByCategoryErrorImpl) then,
  ) = __$$TermsByCategoryErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TermsByCategoryErrorImplCopyWithImpl<$Res>
    extends _$TermsStateCopyWithImpl<$Res, _$TermsByCategoryErrorImpl>
    implements _$$TermsByCategoryErrorImplCopyWith<$Res> {
  __$$TermsByCategoryErrorImplCopyWithImpl(
    _$TermsByCategoryErrorImpl _value,
    $Res Function(_$TermsByCategoryErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$TermsByCategoryErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$TermsByCategoryErrorImpl implements TermsByCategoryError {
  const _$TermsByCategoryErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TermsState.termsByCategoryError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermsByCategoryErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermsByCategoryErrorImplCopyWith<_$TermsByCategoryErrorImpl>
  get copyWith =>
      __$$TermsByCategoryErrorImplCopyWithImpl<_$TermsByCategoryErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() allTermsLoading,
    required TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )
    allTermsLoaded,
    required TResult Function(String message) allTermsError,
    required TResult Function() termsByCategoryLoading,
    required TResult Function(List<TermModel> terms) termsByCategoryLoaded,
    required TResult Function(String message) termsByCategoryError,
  }) {
    return termsByCategoryError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? allTermsLoading,
    TResult? Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult? Function(String message)? allTermsError,
    TResult? Function()? termsByCategoryLoading,
    TResult? Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult? Function(String message)? termsByCategoryError,
  }) {
    return termsByCategoryError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? allTermsLoading,
    TResult Function(
      List<TermModel> terms,
      bool hasMore,
      int currentPage,
      int totalCount,
      bool isLoadingMore,
      String? pendingLetter,
      String? letterJustLoaded,
      bool isLetterLoading,
      Map<String, List<TermModel>> groupedTerms,
    )?
    allTermsLoaded,
    TResult Function(String message)? allTermsError,
    TResult Function()? termsByCategoryLoading,
    TResult Function(List<TermModel> terms)? termsByCategoryLoaded,
    TResult Function(String message)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (termsByCategoryError != null) {
      return termsByCategoryError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TermsInitial value) initial,
    required TResult Function(AllTermsLoading value) allTermsLoading,
    required TResult Function(AllTermsLoaded value) allTermsLoaded,
    required TResult Function(AllTermsError value) allTermsError,
    required TResult Function(TermsByCategoryLoading value)
    termsByCategoryLoading,
    required TResult Function(TermsByCategoryLoaded value)
    termsByCategoryLoaded,
    required TResult Function(TermsByCategoryError value) termsByCategoryError,
  }) {
    return termsByCategoryError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TermsInitial value)? initial,
    TResult? Function(AllTermsLoading value)? allTermsLoading,
    TResult? Function(AllTermsLoaded value)? allTermsLoaded,
    TResult? Function(AllTermsError value)? allTermsError,
    TResult? Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult? Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult? Function(TermsByCategoryError value)? termsByCategoryError,
  }) {
    return termsByCategoryError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TermsInitial value)? initial,
    TResult Function(AllTermsLoading value)? allTermsLoading,
    TResult Function(AllTermsLoaded value)? allTermsLoaded,
    TResult Function(AllTermsError value)? allTermsError,
    TResult Function(TermsByCategoryLoading value)? termsByCategoryLoading,
    TResult Function(TermsByCategoryLoaded value)? termsByCategoryLoaded,
    TResult Function(TermsByCategoryError value)? termsByCategoryError,
    required TResult orElse(),
  }) {
    if (termsByCategoryError != null) {
      return termsByCategoryError(this);
    }
    return orElse();
  }
}

abstract class TermsByCategoryError implements TermsState {
  const factory TermsByCategoryError(final String message) =
      _$TermsByCategoryErrorImpl;

  String get message;

  /// Create a copy of TermsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermsByCategoryErrorImplCopyWith<_$TermsByCategoryErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
