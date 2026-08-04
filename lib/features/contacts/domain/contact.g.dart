// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Contact _$ContactFromJson(Map<String, dynamic> json) => _Contact(
  id: json['id'] as String,
  name: json['name'] as String,
  phoneNumbers:
      (json['phoneNumbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  emails:
      (json['emails'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  address: json['address'] as String?,
  company: json['company'] as String?,
  notes: json['notes'] as String?,
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  isFavorite: json['isFavorite'] as bool? ?? false,
  profilePicturePath: json['profilePicturePath'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ContactToJson(_Contact instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phoneNumbers': instance.phoneNumbers,
  'emails': instance.emails,
  'address': instance.address,
  'company': instance.company,
  'notes': instance.notes,
  'birthday': instance.birthday?.toIso8601String(),
  'isFavorite': instance.isFavorite,
  'profilePicturePath': instance.profilePicturePath,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
