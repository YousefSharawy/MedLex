// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'az_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AzListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )
    loaded,
    required TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )
    scrollToLetter,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )?
    loaded,
    TResult? Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )?
    scrollToLetter,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )?
    loaded,
    TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )?
    scrollToLetter,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ScrollToLetter value) scrollToLetter,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ScrollToLetter value)? scrollToLetter,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ScrollToLetter value)? scrollToLetter,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AzListStateCopyWith<$Res> {
  factory $AzListStateCopyWith(
    AzListState value,
    $Res Function(AzListState) then,
  ) = _$AzListStateCopyWithImpl<$Res, AzListState>;
}

/// @nodoc
class _$AzListStateCopyWithImpl<$Res, $Val extends AzListState>
    implements $AzListStateCopyWith<$Res> {
  _$AzListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AzListStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AzListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )
    loaded,
    required TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )
    scrollToLetter,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )?
    loaded,
    TResult? Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )?
    scrollToLetter,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )?
    loaded,
    TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )?
    scrollToLetter,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ScrollToLetter value) scrollToLetter,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ScrollToLetter value)? scrollToLetter,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ScrollToLetter value)? scrollToLetter,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AzListState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<AzItem> azItems,
    Set<String> availableLetters,
    String selectedCategory,
    String? pendingScrollLetter,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$AzListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? azItems = null,
    Object? availableLetters = null,
    Object? selectedCategory = null,
    Object? pendingScrollLetter = freezed,
  }) {
    return _then(
      _$LoadedImpl(
        azItems:
            null == azItems
                ? _value._azItems
                : azItems // ignore: cast_nullable_to_non_nullable
                    as List<AzItem>,
        availableLetters:
            null == availableLetters
                ? _value._availableLetters
                : availableLetters // ignore: cast_nullable_to_non_nullable
                    as Set<String>,
        selectedCategory:
            null == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                    as String,
        pendingScrollLetter:
            freezed == pendingScrollLetter
                ? _value.pendingScrollLetter
                : pendingScrollLetter // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required final List<AzItem> azItems,
    required final Set<String> availableLetters,
    required this.selectedCategory,
    this.pendingScrollLetter,
  }) : _azItems = azItems,
       _availableLetters = availableLetters;

  final List<AzItem> _azItems;
  @override
  List<AzItem> get azItems {
    if (_azItems is EqualUnmodifiableListView) return _azItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_azItems);
  }

  final Set<String> _availableLetters;
  @override
  Set<String> get availableLetters {
    if (_availableLetters is EqualUnmodifiableSetView) return _availableLetters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_availableLetters);
  }

  @override
  final String selectedCategory;
  @override
  final String? pendingScrollLetter;

  @override
  String toString() {
    return 'AzListState.loaded(azItems: $azItems, availableLetters: $availableLetters, selectedCategory: $selectedCategory, pendingScrollLetter: $pendingScrollLetter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._azItems, _azItems) &&
            const DeepCollectionEquality().equals(
              other._availableLetters,
              _availableLetters,
            ) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.pendingScrollLetter, pendingScrollLetter) ||
                other.pendingScrollLetter == pendingScrollLetter));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_azItems),
    const DeepCollectionEquality().hash(_availableLetters),
    selectedCategory,
    pendingScrollLetter,
  );

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )
    loaded,
    required TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )
    scrollToLetter,
  }) {
    return loaded(
      azItems,
      availableLetters,
      selectedCategory,
      pendingScrollLetter,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )?
    loaded,
    TResult? Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )?
    scrollToLetter,
  }) {
    return loaded?.call(
      azItems,
      availableLetters,
      selectedCategory,
      pendingScrollLetter,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )?
    loaded,
    TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )?
    scrollToLetter,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        azItems,
        availableLetters,
        selectedCategory,
        pendingScrollLetter,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ScrollToLetter value) scrollToLetter,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ScrollToLetter value)? scrollToLetter,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ScrollToLetter value)? scrollToLetter,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements AzListState {
  const factory _Loaded({
    required final List<AzItem> azItems,
    required final Set<String> availableLetters,
    required final String selectedCategory,
    final String? pendingScrollLetter,
  }) = _$LoadedImpl;

  List<AzItem> get azItems;
  Set<String> get availableLetters;
  String get selectedCategory;
  String? get pendingScrollLetter;

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ScrollToLetterImplCopyWith<$Res> {
  factory _$$ScrollToLetterImplCopyWith(
    _$ScrollToLetterImpl value,
    $Res Function(_$ScrollToLetterImpl) then,
  ) = __$$ScrollToLetterImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<AzItem> azItems,
    Set<String> availableLetters,
    String selectedCategory,
    String letter,
    int targetIndex,
  });
}

/// @nodoc
class __$$ScrollToLetterImplCopyWithImpl<$Res>
    extends _$AzListStateCopyWithImpl<$Res, _$ScrollToLetterImpl>
    implements _$$ScrollToLetterImplCopyWith<$Res> {
  __$$ScrollToLetterImplCopyWithImpl(
    _$ScrollToLetterImpl _value,
    $Res Function(_$ScrollToLetterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? azItems = null,
    Object? availableLetters = null,
    Object? selectedCategory = null,
    Object? letter = null,
    Object? targetIndex = null,
  }) {
    return _then(
      _$ScrollToLetterImpl(
        azItems:
            null == azItems
                ? _value._azItems
                : azItems // ignore: cast_nullable_to_non_nullable
                    as List<AzItem>,
        availableLetters:
            null == availableLetters
                ? _value._availableLetters
                : availableLetters // ignore: cast_nullable_to_non_nullable
                    as Set<String>,
        selectedCategory:
            null == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                    as String,
        letter:
            null == letter
                ? _value.letter
                : letter // ignore: cast_nullable_to_non_nullable
                    as String,
        targetIndex:
            null == targetIndex
                ? _value.targetIndex
                : targetIndex // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$ScrollToLetterImpl implements _ScrollToLetter {
  const _$ScrollToLetterImpl({
    required final List<AzItem> azItems,
    required final Set<String> availableLetters,
    required this.selectedCategory,
    required this.letter,
    required this.targetIndex,
  }) : _azItems = azItems,
       _availableLetters = availableLetters;

  final List<AzItem> _azItems;
  @override
  List<AzItem> get azItems {
    if (_azItems is EqualUnmodifiableListView) return _azItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_azItems);
  }

  final Set<String> _availableLetters;
  @override
  Set<String> get availableLetters {
    if (_availableLetters is EqualUnmodifiableSetView) return _availableLetters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_availableLetters);
  }

  @override
  final String selectedCategory;
  @override
  final String letter;
  @override
  final int targetIndex;

  @override
  String toString() {
    return 'AzListState.scrollToLetter(azItems: $azItems, availableLetters: $availableLetters, selectedCategory: $selectedCategory, letter: $letter, targetIndex: $targetIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrollToLetterImpl &&
            const DeepCollectionEquality().equals(other._azItems, _azItems) &&
            const DeepCollectionEquality().equals(
              other._availableLetters,
              _availableLetters,
            ) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.letter, letter) || other.letter == letter) &&
            (identical(other.targetIndex, targetIndex) ||
                other.targetIndex == targetIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_azItems),
    const DeepCollectionEquality().hash(_availableLetters),
    selectedCategory,
    letter,
    targetIndex,
  );

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScrollToLetterImplCopyWith<_$ScrollToLetterImpl> get copyWith =>
      __$$ScrollToLetterImplCopyWithImpl<_$ScrollToLetterImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )
    loaded,
    required TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )
    scrollToLetter,
  }) {
    return scrollToLetter(
      azItems,
      availableLetters,
      selectedCategory,
      letter,
      targetIndex,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )?
    loaded,
    TResult? Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )?
    scrollToLetter,
  }) {
    return scrollToLetter?.call(
      azItems,
      availableLetters,
      selectedCategory,
      letter,
      targetIndex,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String? pendingScrollLetter,
    )?
    loaded,
    TResult Function(
      List<AzItem> azItems,
      Set<String> availableLetters,
      String selectedCategory,
      String letter,
      int targetIndex,
    )?
    scrollToLetter,
    required TResult orElse(),
  }) {
    if (scrollToLetter != null) {
      return scrollToLetter(
        azItems,
        availableLetters,
        selectedCategory,
        letter,
        targetIndex,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ScrollToLetter value) scrollToLetter,
  }) {
    return scrollToLetter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ScrollToLetter value)? scrollToLetter,
  }) {
    return scrollToLetter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ScrollToLetter value)? scrollToLetter,
    required TResult orElse(),
  }) {
    if (scrollToLetter != null) {
      return scrollToLetter(this);
    }
    return orElse();
  }
}

abstract class _ScrollToLetter implements AzListState {
  const factory _ScrollToLetter({
    required final List<AzItem> azItems,
    required final Set<String> availableLetters,
    required final String selectedCategory,
    required final String letter,
    required final int targetIndex,
  }) = _$ScrollToLetterImpl;

  List<AzItem> get azItems;
  Set<String> get availableLetters;
  String get selectedCategory;
  String get letter;
  int get targetIndex;

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScrollToLetterImplCopyWith<_$ScrollToLetterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
