// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class TermModel with _$TermModel {
  const factory TermModel({
    required int id,
    @JsonKey(name: 'latin_term') required String latinTerm,
    @JsonKey(name: 'pronunciation') @Default('') String pronunciation,
    @JsonKey(name: 'english_term') @Default('') String englishTerm,
    @JsonKey(name: 'english_definition') @Default('') String englishDefinition,
    @JsonKey(name: 'causes', fromJson: _parseStringOrList) String? causes,
    @JsonKey(name: 'symptoms', fromJson: _parseStringOrList) String? symptoms,
    @JsonKey(name: 'treatment', fromJson: _parseStringOrList) String? treatment,
    @JsonKey(name: 'differential_diagnoses', fromJson: _parseStringOrList)
    String? differentialDiagnoses,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'simple_definition') @Default('') String simpleDefinition,
    @JsonKey(name: 'academic_definition') @Default('') String academicDefinition,
    @JsonKey(name: 'category') @Default('General') String category,
    @JsonKey(name: 'cloudinary_public_id') String? cloudinaryPublicId,
    @JsonKey(name: 'has_image') @Default(false) bool hasImage,
    @JsonKey(includeFromJson: false, includeToJson: false) @Default(false) bool isSaved,
  }) = _TermModel;

  factory TermModel.fromJson(Map<String, dynamic> json) => _$TermModelFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    String? email,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @Default(true) bool isAnonymous,
  }) = _UserModel;

  const UserModel._();

  bool get isAuthenticated => !isAnonymous && email != null;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Create from Supabase auth User object
  factory UserModel.fromSupabaseUser(dynamic user, {required bool isAnonymous}) {
    return UserModel(
      id: user.id,
      email: user.email,
      displayName: user.userMetadata?['full_name'] as String?,
      photoUrl: user.userMetadata?['avatar_url'] as String?,
      isAnonymous: isAnonymous,
    );
  }

  factory UserModel.anonymous(String userId) {
    return UserModel(id: userId, isAnonymous: true);
  }
}

String? _parseStringOrList(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is List) {
    return value.map((e) => e.toString()).join(', ');
  }
  return value.toString();
}