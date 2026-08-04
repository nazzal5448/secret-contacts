import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
abstract class Contact with _$Contact {
  const Contact._();

  const factory Contact({
    required String id,
    required String name,
    @Default([]) List<String> phoneNumbers,
    @Default([]) List<String> emails,
    String? address,
    String? company,
    String? notes,
    DateTime? birthday,
    @Default(false) bool isFavorite,
    String? profilePicturePath,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}
