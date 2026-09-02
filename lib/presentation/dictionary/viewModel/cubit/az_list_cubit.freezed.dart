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
  List<AzItem> get azItems => throw _privateConstructorUsedError;
  Set<String> get availableLetters => throw _privateConstructorUsedError;
  bool get isNavigating => throw _privateConstructorUsedError;

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AzListStateCopyWith<AzListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AzListStateCopyWith<$Res> {
  factory $AzListStateCopyWith(
    AzListState value,
    $Res Function(AzListState) then,
  ) = _$AzListStateCopyWithImpl<$Res, AzListState>;
  @useResult
  $Res call({
    List<AzItem> azItems,
    Set<String> availableLetters,
    bool isNavigating,
  });
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? azItems = null,
    Object? availableLetters = null,
    Object? isNavigating = null,
  }) {
    return _then(
      _value.copyWith(
            azItems:
                null == azItems
                    ? _value.azItems
                    : azItems // ignore: cast_nullable_to_non_nullable
                        as List<AzItem>,
            availableLetters:
                null == availableLetters
                    ? _value.availableLetters
                    : availableLetters // ignore: cast_nullable_to_non_nullable
                        as Set<String>,
            isNavigating:
                null == isNavigating
                    ? _value.isNavigating
                    : isNavigating // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $AzListStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AzItem> azItems,
    Set<String> availableLetters,
    bool isNavigating,
  });
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? azItems = null,
    Object? availableLetters = null,
    Object? isNavigating = null,
  }) {
    return _then(
      _$InitialImpl(
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
        isNavigating:
            null == isNavigating
                ? _value.isNavigating
                : isNavigating // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({
    final List<AzItem> azItems = const [],
    final Set<String> availableLetters = const {},
    this.isNavigating = false,
  }) : _azItems = azItems,
       _availableLetters = availableLetters;

  final List<AzItem> _azItems;
  @override
  @JsonKey()
  List<AzItem> get azItems {
    if (_azItems is EqualUnmodifiableListView) return _azItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_azItems);
  }

  final Set<String> _availableLetters;
  @override
  @JsonKey()
  Set<String> get availableLetters {
    if (_availableLetters is EqualUnmodifiableSetView) return _availableLetters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_availableLetters);
  }

  @override
  @JsonKey()
  final bool isNavigating;

  @override
  String toString() {
    return 'AzListState(azItems: $azItems, availableLetters: $availableLetters, isNavigating: $isNavigating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality().equals(other._azItems, _azItems) &&
            const DeepCollectionEquality().equals(
              other._availableLetters,
              _availableLetters,
            ) &&
            (identical(other.isNavigating, isNavigating) ||
                other.isNavigating == isNavigating));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_azItems),
    const DeepCollectionEquality().hash(_availableLetters),
    isNavigating,
  );

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial implements AzListState {
  const factory _Initial({
    final List<AzItem> azItems,
    final Set<String> availableLetters,
    final bool isNavigating,
  }) = _$InitialImpl;

  @override
  List<AzItem> get azItems;
  @override
  Set<String> get availableLetters;
  @override
  bool get isNavigating;

  /// Create a copy of AzListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
