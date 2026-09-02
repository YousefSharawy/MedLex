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
      differentialDiagnoses: _parseStringOrList(json['differential_diagnoses']),
      imageUrl: json['image_url'] as String?,
      simpleDefinition: json['simple_definition'] as String? ?? '',
      academicDefinition: json['academic_definition'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      cloudinaryPublicId: json['cloudinary_public_id'] as String?,
      hasImage: json['has_image'] as bool? ?? false,
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
      'differential_diagnoses': instance.differentialDiagnoses,
      'image_url': instance.imageUrl,
      'simple_definition': instance.simpleDefinition,
      'academic_definition': instance.academicDefinition,
      'category': instance.category,
      'cloudinary_public_id': instance.cloudinaryPublicId,
      'has_image': instance.hasImage,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      isAnonymous: json['isAnonymous'] as bool? ?? true,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'photo_url': instance.photoUrl,
      'isAnonymous': instance.isAnonymous,
    };
