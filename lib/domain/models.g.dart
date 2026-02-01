// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermModelImpl _$$TermModelImplFromJson(Map<String, dynamic> json) =>
    _$TermModelImpl(
      id: (json['id'] as num).toInt(),
      latinTerm: json['latin_term'] as String,
      pronunciation: json['pronunciation'] as String? ?? '',
      englishTerm: json['english_term'] as String? ?? '',
      englishDefinition: json['english_definition'] as String? ?? '',
      causes: _parseStringOrList(json['causes']),
      symptoms: _parseStringOrList(json['symptoms']),
      treatment: _parseStringOrList(json['treatment']),
      imageUrl: json['image_url'] as String?,
      simpleDefinition: json['simple_definition'] as String? ?? '',
      academicDefinition: json['academic_definition'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
    );

Map<String, dynamic> _$$TermModelImplToJson(_$TermModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latin_term': instance.latinTerm,
      'pronunciation': instance.pronunciation,
      'english_term': instance.englishTerm,
      'english_definition': instance.englishDefinition,
      'causes': instance.causes,
      'symptoms': instance.symptoms,
      'treatment': instance.treatment,
      'image_url': instance.imageUrl,
      'simple_definition': instance.simpleDefinition,
      'academic_definition': instance.academicDefinition,
      'category': instance.category,
    };
