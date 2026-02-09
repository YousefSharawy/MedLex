// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
    )
    loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
    )?
    loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
    )?
    loaded,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchInitial value) initial,
    required TResult Function(SearchLoaded value) loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchInitial value)? initial,
    TResult? Function(SearchLoaded value)? loaded,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchInitial value)? initial,
    TResult Function(SearchLoaded value)? loaded,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
    SearchState value,
    $Res Function(SearchState) then,
  ) = _$SearchStateCopyWithImpl<$Res, SearchState>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchInitialImplCopyWith<$Res> {
  factory _$$SearchInitialImplCopyWith(
    _$SearchInitialImpl value,
    $Res Function(_$SearchInitialImpl) then,
  ) = __$$SearchInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchInitialImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchInitialImpl>
    implements _$$SearchInitialImplCopyWith<$Res> {
  __$$SearchInitialImplCopyWithImpl(
    _$SearchInitialImpl _value,
    $Res Function(_$SearchInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SearchInitialImpl implements _SearchInitial {
  const _$SearchInitialImpl();

  @override
  String toString() {
    return 'SearchState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
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
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
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
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
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
    required TResult Function(_SearchInitial value) initial,
    required TResult Function(SearchLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchInitial value)? initial,
    TResult? Function(SearchLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchInitial value)? initial,
    TResult Function(SearchLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _SearchInitial implements SearchState {
  const factory _SearchInitial() = _$SearchInitialImpl;
}

/// @nodoc
abstract class _$$SearchLoadedImplCopyWith<$Res> {
  factory _$$SearchLoadedImplCopyWith(
    _$SearchLoadedImpl value,
    $Res Function(_$SearchLoadedImpl) then,
  ) = __$$SearchLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    bool isSearching,
    List<TermModel>? searchResults,
    bool isSearchLoading,
    String? searchError,
    List<String> recentlySearched,
    String? pendingSearchText,
  });
}

/// @nodoc
class __$$SearchLoadedImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchLoadedImpl>
    implements _$$SearchLoadedImplCopyWith<$Res> {
  __$$SearchLoadedImplCopyWithImpl(
    _$SearchLoadedImpl _value,
    $Res Function(_$SearchLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSearching = null,
    Object? searchResults = freezed,
    Object? isSearchLoading = null,
    Object? searchError = freezed,
    Object? recentlySearched = null,
    Object? pendingSearchText = freezed,
  }) {
    return _then(
      _$SearchLoadedImpl(
        isSearching:
            null == isSearching
                ? _value.isSearching
                : isSearching // ignore: cast_nullable_to_non_nullable
                    as bool,
        searchResults:
            freezed == searchResults
                ? _value._searchResults
                : searchResults // ignore: cast_nullable_to_non_nullable
                    as List<TermModel>?,
        isSearchLoading:
            null == isSearchLoading
                ? _value.isSearchLoading
                : isSearchLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        searchError:
            freezed == searchError
                ? _value.searchError
                : searchError // ignore: cast_nullable_to_non_nullable
                    as String?,
        recentlySearched:
            null == recentlySearched
                ? _value._recentlySearched
                : recentlySearched // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        pendingSearchText:
            freezed == pendingSearchText
                ? _value.pendingSearchText
                : pendingSearchText // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$SearchLoadedImpl implements SearchLoaded {
  const _$SearchLoadedImpl({
    this.isSearching = false,
    final List<TermModel>? searchResults,
    this.isSearchLoading = false,
    this.searchError,
    final List<String> recentlySearched = const [],
    this.pendingSearchText,
  }) : _searchResults = searchResults,
       _recentlySearched = recentlySearched;

  @override
  @JsonKey()
  final bool isSearching;
  final List<TermModel>? _searchResults;
  @override
  List<TermModel>? get searchResults {
    final value = _searchResults;
    if (value == null) return null;
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isSearchLoading;
  @override
  final String? searchError;
  final List<String> _recentlySearched;
  @override
  @JsonKey()
  List<String> get recentlySearched {
    if (_recentlySearched is EqualUnmodifiableListView)
      return _recentlySearched;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentlySearched);
  }

  @override
  final String? pendingSearchText;

  @override
  String toString() {
    return 'SearchState.loaded(isSearching: $isSearching, searchResults: $searchResults, isSearchLoading: $isSearchLoading, searchError: $searchError, recentlySearched: $recentlySearched, pendingSearchText: $pendingSearchText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchLoadedImpl &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            const DeepCollectionEquality().equals(
              other._searchResults,
              _searchResults,
            ) &&
            (identical(other.isSearchLoading, isSearchLoading) ||
                other.isSearchLoading == isSearchLoading) &&
            (identical(other.searchError, searchError) ||
                other.searchError == searchError) &&
            const DeepCollectionEquality().equals(
              other._recentlySearched,
              _recentlySearched,
            ) &&
            (identical(other.pendingSearchText, pendingSearchText) ||
                other.pendingSearchText == pendingSearchText));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isSearching,
    const DeepCollectionEquality().hash(_searchResults),
    isSearchLoading,
    searchError,
    const DeepCollectionEquality().hash(_recentlySearched),
    pendingSearchText,
  );

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchLoadedImplCopyWith<_$SearchLoadedImpl> get copyWith =>
      __$$SearchLoadedImplCopyWithImpl<_$SearchLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
    )
    loaded,
  }) {
    return loaded(
      isSearching,
      searchResults,
      isSearchLoading,
      searchError,
      recentlySearched,
      pendingSearchText,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
    )?
    loaded,
  }) {
    return loaded?.call(
      isSearching,
      searchResults,
      isSearchLoading,
      searchError,
      recentlySearched,
      pendingSearchText,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      bool isSearching,
      List<TermModel>? searchResults,
      bool isSearchLoading,
      String? searchError,
      List<String> recentlySearched,
      String? pendingSearchText,
    )?
    loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        isSearching,
        searchResults,
        isSearchLoading,
        searchError,
        recentlySearched,
        pendingSearchText,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchInitial value) initial,
    required TResult Function(SearchLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchInitial value)? initial,
    TResult? Function(SearchLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchInitial value)? initial,
    TResult Function(SearchLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SearchLoaded implements SearchState {
  const factory SearchLoaded({
    final bool isSearching,
    final List<TermModel>? searchResults,
    final bool isSearchLoading,
    final String? searchError,
    final List<String> recentlySearched,
    final String? pendingSearchText,
  }) = _$SearchLoadedImpl;

  bool get isSearching;
  List<TermModel>? get searchResults;
  bool get isSearchLoading;
  String? get searchError;
  List<String> get recentlySearched;
  String? get pendingSearchText;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchLoadedImplCopyWith<_$SearchLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
