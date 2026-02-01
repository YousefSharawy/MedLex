// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TermModel _$TermModelFromJson(Map<String, dynamic> json) {
  return _TermModel.fromJson(json);
}

/// @nodoc
mixin _$TermModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'latin_term')
  String get latinTerm => throw _privateConstructorUsedError;
  @JsonKey(name: 'pronunciation')
  String get pronunciation => throw _privateConstructorUsedError;
  @JsonKey(name: 'english_term')
  String get englishTerm => throw _privateConstructorUsedError;
  @JsonKey(name: 'english_definition')
  String get englishDefinition => throw _privateConstructorUsedError;
  @JsonKey(name: 'causes', fromJson: _parseStringOrList)
  String? get causes => throw _privateConstructorUsedError;
  @JsonKey(name: 'symptoms', fromJson: _parseStringOrList)
  String? get symptoms => throw _privateConstructorUsedError;
  @JsonKey(name: 'treatment', fromJson: _parseStringOrList)
  String? get treatment => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'simple_definition')
  String get simpleDefinition => throw _privateConstructorUsedError;
  @JsonKey(name: 'academic_definition')
  String get academicDefinition => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String get category => throw _privateConstructorUsedError;

  /// Serializes this TermModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TermModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TermModelCopyWith<TermModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermModelCopyWith<$Res> {
  factory $TermModelCopyWith(TermModel value, $Res Function(TermModel) then) =
      _$TermModelCopyWithImpl<$Res, TermModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'latin_term') String latinTerm,
    @JsonKey(name: 'pronunciation') String pronunciation,
    @JsonKey(name: 'english_term') String englishTerm,
    @JsonKey(name: 'english_definition') String englishDefinition,
    @JsonKey(name: 'causes', fromJson: _parseStringOrList) String? causes,
    @JsonKey(name: 'symptoms', fromJson: _parseStringOrList) String? symptoms,
    @JsonKey(name: 'treatment', fromJson: _parseStringOrList) String? treatment,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'simple_definition') String simpleDefinition,
    @JsonKey(name: 'academic_definition') String academicDefinition,
    @JsonKey(name: 'category') String category,
  });
}

/// @nodoc
class _$TermModelCopyWithImpl<$Res, $Val extends TermModel>
    implements $TermModelCopyWith<$Res> {
  _$TermModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TermModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latinTerm = null,
    Object? pronunciation = null,
    Object? englishTerm = null,
    Object? englishDefinition = null,
    Object? causes = freezed,
    Object? symptoms = freezed,
    Object? treatment = freezed,
    Object? imageUrl = freezed,
    Object? simpleDefinition = null,
    Object? academicDefinition = null,
    Object? category = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            latinTerm:
                null == latinTerm
                    ? _value.latinTerm
                    : latinTerm // ignore: cast_nullable_to_non_nullable
                        as String,
            pronunciation:
                null == pronunciation
                    ? _value.pronunciation
                    : pronunciation // ignore: cast_nullable_to_non_nullable
                        as String,
            englishTerm:
                null == englishTerm
                    ? _value.englishTerm
                    : englishTerm // ignore: cast_nullable_to_non_nullable
                        as String,
            englishDefinition:
                null == englishDefinition
                    ? _value.englishDefinition
                    : englishDefinition // ignore: cast_nullable_to_non_nullable
                        as String,
            causes:
                freezed == causes
                    ? _value.causes
                    : causes // ignore: cast_nullable_to_non_nullable
                        as String?,
            symptoms:
                freezed == symptoms
                    ? _value.symptoms
                    : symptoms // ignore: cast_nullable_to_non_nullable
                        as String?,
            treatment:
                freezed == treatment
                    ? _value.treatment
                    : treatment // ignore: cast_nullable_to_non_nullable
                        as String?,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            simpleDefinition:
                null == simpleDefinition
                    ? _value.simpleDefinition
                    : simpleDefinition // ignore: cast_nullable_to_non_nullable
                        as String,
            academicDefinition:
                null == academicDefinition
                    ? _value.academicDefinition
                    : academicDefinition // ignore: cast_nullable_to_non_nullable
                        as String,
            category:
                null == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TermModelImplCopyWith<$Res>
    implements $TermModelCopyWith<$Res> {
  factory _$$TermModelImplCopyWith(
    _$TermModelImpl value,
    $Res Function(_$TermModelImpl) then,
  ) = __$$TermModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'latin_term') String latinTerm,
    @JsonKey(name: 'pronunciation') String pronunciation,
    @JsonKey(name: 'english_term') String englishTerm,
    @JsonKey(name: 'english_definition') String englishDefinition,
    @JsonKey(name: 'causes', fromJson: _parseStringOrList) String? causes,
    @JsonKey(name: 'symptoms', fromJson: _parseStringOrList) String? symptoms,
    @JsonKey(name: 'treatment', fromJson: _parseStringOrList) String? treatment,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'simple_definition') String simpleDefinition,
    @JsonKey(name: 'academic_definition') String academicDefinition,
    @JsonKey(name: 'category') String category,
  });
}

/// @nodoc
class __$$TermModelImplCopyWithImpl<$Res>
    extends _$TermModelCopyWithImpl<$Res, _$TermModelImpl>
    implements _$$TermModelImplCopyWith<$Res> {
  __$$TermModelImplCopyWithImpl(
    _$TermModelImpl _value,
    $Res Function(_$TermModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TermModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latinTerm = null,
    Object? pronunciation = null,
    Object? englishTerm = null,
    Object? englishDefinition = null,
    Object? causes = freezed,
    Object? symptoms = freezed,
    Object? treatment = freezed,
    Object? imageUrl = freezed,
    Object? simpleDefinition = null,
    Object? academicDefinition = null,
    Object? category = null,
  }) {
    return _then(
      _$TermModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        latinTerm:
            null == latinTerm
                ? _value.latinTerm
                : latinTerm // ignore: cast_nullable_to_non_nullable
                    as String,
        pronunciation:
            null == pronunciation
                ? _value.pronunciation
                : pronunciation // ignore: cast_nullable_to_non_nullable
                    as String,
        englishTerm:
            null == englishTerm
                ? _value.englishTerm
                : englishTerm // ignore: cast_nullable_to_non_nullable
                    as String,
        englishDefinition:
            null == englishDefinition
                ? _value.englishDefinition
                : englishDefinition // ignore: cast_nullable_to_non_nullable
                    as String,
        causes:
            freezed == causes
                ? _value.causes
                : causes // ignore: cast_nullable_to_non_nullable
                    as String?,
        symptoms:
            freezed == symptoms
                ? _value.symptoms
                : symptoms // ignore: cast_nullable_to_non_nullable
                    as String?,
        treatment:
            freezed == treatment
                ? _value.treatment
                : treatment // ignore: cast_nullable_to_non_nullable
                    as String?,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        simpleDefinition:
            null == simpleDefinition
                ? _value.simpleDefinition
                : simpleDefinition // ignore: cast_nullable_to_non_nullable
                    as String,
        academicDefinition:
            null == academicDefinition
                ? _value.academicDefinition
                : academicDefinition // ignore: cast_nullable_to_non_nullable
                    as String,
        category:
            null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TermModelImpl implements _TermModel {
  const _$TermModelImpl({
    required this.id,
    @JsonKey(name: 'latin_term') required this.latinTerm,
    @JsonKey(name: 'pronunciation') this.pronunciation = '',
    @JsonKey(name: 'english_term') this.englishTerm = '',
    @JsonKey(name: 'english_definition') this.englishDefinition = '',
    @JsonKey(name: 'causes', fromJson: _parseStringOrList) this.causes,
    @JsonKey(name: 'symptoms', fromJson: _parseStringOrList) this.symptoms,
    @JsonKey(name: 'treatment', fromJson: _parseStringOrList) this.treatment,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'simple_definition') this.simpleDefinition = '',
    @JsonKey(name: 'academic_definition') this.academicDefinition = '',
    @JsonKey(name: 'category') this.category = 'General',
  });

  factory _$TermModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'latin_term')
  final String latinTerm;
  @override
  @JsonKey(name: 'pronunciation')
  final String pronunciation;
  @override
  @JsonKey(name: 'english_term')
  final String englishTerm;
  @override
  @JsonKey(name: 'english_definition')
  final String englishDefinition;
  @override
  @JsonKey(name: 'causes', fromJson: _parseStringOrList)
  final String? causes;
  @override
  @JsonKey(name: 'symptoms', fromJson: _parseStringOrList)
  final String? symptoms;
  @override
  @JsonKey(name: 'treatment', fromJson: _parseStringOrList)
  final String? treatment;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'simple_definition')
  final String simpleDefinition;
  @override
  @JsonKey(name: 'academic_definition')
  final String academicDefinition;
  @override
  @JsonKey(name: 'category')
  final String category;

  @override
  String toString() {
    return 'TermModel(id: $id, latinTerm: $latinTerm, pronunciation: $pronunciation, englishTerm: $englishTerm, englishDefinition: $englishDefinition, causes: $causes, symptoms: $symptoms, treatment: $treatment, imageUrl: $imageUrl, simpleDefinition: $simpleDefinition, academicDefinition: $academicDefinition, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latinTerm, latinTerm) ||
                other.latinTerm == latinTerm) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.englishTerm, englishTerm) ||
                other.englishTerm == englishTerm) &&
            (identical(other.englishDefinition, englishDefinition) ||
                other.englishDefinition == englishDefinition) &&
            (identical(other.causes, causes) || other.causes == causes) &&
            (identical(other.symptoms, symptoms) ||
                other.symptoms == symptoms) &&
            (identical(other.treatment, treatment) ||
                other.treatment == treatment) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.simpleDefinition, simpleDefinition) ||
                other.simpleDefinition == simpleDefinition) &&
            (identical(other.academicDefinition, academicDefinition) ||
                other.academicDefinition == academicDefinition) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    latinTerm,
    pronunciation,
    englishTerm,
    englishDefinition,
    causes,
    symptoms,
    treatment,
    imageUrl,
    simpleDefinition,
    academicDefinition,
    category,
  );

  /// Create a copy of TermModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermModelImplCopyWith<_$TermModelImpl> get copyWith =>
      __$$TermModelImplCopyWithImpl<_$TermModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermModelImplToJson(this);
  }
}

abstract class _TermModel implements TermModel {
  const factory _TermModel({
    required final int id,
    @JsonKey(name: 'latin_term') required final String latinTerm,
    @JsonKey(name: 'pronunciation') final String pronunciation,
    @JsonKey(name: 'english_term') final String englishTerm,
    @JsonKey(name: 'english_definition') final String englishDefinition,
    @JsonKey(name: 'causes', fromJson: _parseStringOrList) final String? causes,
    @JsonKey(name: 'symptoms', fromJson: _parseStringOrList)
    final String? symptoms,
    @JsonKey(name: 'treatment', fromJson: _parseStringOrList)
    final String? treatment,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'simple_definition') final String simpleDefinition,
    @JsonKey(name: 'academic_definition') final String academicDefinition,
    @JsonKey(name: 'category') final String category,
  }) = _$TermModelImpl;

  factory _TermModel.fromJson(Map<String, dynamic> json) =
      _$TermModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'latin_term')
  String get latinTerm;
  @override
  @JsonKey(name: 'pronunciation')
  String get pronunciation;
  @override
  @JsonKey(name: 'english_term')
  String get englishTerm;
  @override
  @JsonKey(name: 'english_definition')
  String get englishDefinition;
  @override
  @JsonKey(name: 'causes', fromJson: _parseStringOrList)
  String? get causes;
  @override
  @JsonKey(name: 'symptoms', fromJson: _parseStringOrList)
  String? get symptoms;
  @override
  @JsonKey(name: 'treatment', fromJson: _parseStringOrList)
  String? get treatment;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'simple_definition')
  String get simpleDefinition;
  @override
  @JsonKey(name: 'academic_definition')
  String get academicDefinition;
  @override
  @JsonKey(name: 'category')
  String get category;

  /// Create a copy of TermModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermModelImplCopyWith<_$TermModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
