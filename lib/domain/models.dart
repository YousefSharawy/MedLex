import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class TermModel with _$TermModel {
  const TermModel._();

  const factory TermModel({
    required int id,
    @JsonKey(name: 'latin_term') required String latinTerm,
    required String pronunciation,
    @JsonKey(name: 'english_term') required String englishTerm,
    @JsonKey(name: 'english_definition') required String englishDefinition,
    String? causes,
    String? symptoms,
    String? treatment,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'simple_definition') required String simpleDefinition,
    @JsonKey(name: 'academic_definition') required String academicDefinition,
    required String category,
  }) = _TermModel;

  factory TermModel.fromJson(Map<String, dynamic> json) =>
      _$TermModelFromJson(json);
}