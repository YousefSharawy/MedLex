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
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'simple_definition') @Default('') String simpleDefinition,
    @JsonKey(name: 'academic_definition') @Default('') String academicDefinition,
    @JsonKey(name: 'category') @Default('General') String category,
  }) = _TermModel;

  factory TermModel.fromJson(Map<String, dynamic> json) => _$TermModelFromJson(json);
}

String? _parseStringOrList(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is List) {
    // Join list items with comma or newline
    return value.map((e) => e.toString()).join(', ');
  }
  return value.toString();
}