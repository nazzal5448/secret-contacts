// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Contact {

 String get id; String get name; List<String> get phoneNumbers; List<String> get emails; String? get address; String? get company; String? get notes; DateTime? get birthday; bool get isFavorite; String? get profilePicturePath; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactCopyWith<Contact> get copyWith => _$ContactCopyWithImpl<Contact>(this as Contact, _$identity);

  /// Serializes this Contact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Contact&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.phoneNumbers, phoneNumbers)&&const DeepCollectionEquality().equals(other.emails, emails)&&(identical(other.address, address) || other.address == address)&&(identical(other.company, company) || other.company == company)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.profilePicturePath, profilePicturePath) || other.profilePicturePath == profilePicturePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(phoneNumbers),const DeepCollectionEquality().hash(emails),address,company,notes,birthday,isFavorite,profilePicturePath,createdAt,updatedAt);

@override
String toString() {
  return 'Contact(id: $id, name: $name, phoneNumbers: $phoneNumbers, emails: $emails, address: $address, company: $company, notes: $notes, birthday: $birthday, isFavorite: $isFavorite, profilePicturePath: $profilePicturePath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ContactCopyWith<$Res>  {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) _then) = _$ContactCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> phoneNumbers, List<String> emails, String? address, String? company, String? notes, DateTime? birthday, bool isFavorite, String? profilePicturePath, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ContactCopyWithImpl<$Res>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._self, this._then);

  final Contact _self;
  final $Res Function(Contact) _then;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phoneNumbers = null,Object? emails = null,Object? address = freezed,Object? company = freezed,Object? notes = freezed,Object? birthday = freezed,Object? isFavorite = null,Object? profilePicturePath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumbers: null == phoneNumbers ? _self.phoneNumbers : phoneNumbers // ignore: cast_nullable_to_non_nullable
as List<String>,emails: null == emails ? _self.emails : emails // ignore: cast_nullable_to_non_nullable
as List<String>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,profilePicturePath: freezed == profilePicturePath ? _self.profilePicturePath : profilePicturePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Contact].
extension ContactPatterns on Contact {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Contact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Contact value)  $default,){
final _that = this;
switch (_that) {
case _Contact():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Contact value)?  $default,){
final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> phoneNumbers,  List<String> emails,  String? address,  String? company,  String? notes,  DateTime? birthday,  bool isFavorite,  String? profilePicturePath,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumbers,_that.emails,_that.address,_that.company,_that.notes,_that.birthday,_that.isFavorite,_that.profilePicturePath,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> phoneNumbers,  List<String> emails,  String? address,  String? company,  String? notes,  DateTime? birthday,  bool isFavorite,  String? profilePicturePath,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Contact():
return $default(_that.id,_that.name,_that.phoneNumbers,_that.emails,_that.address,_that.company,_that.notes,_that.birthday,_that.isFavorite,_that.profilePicturePath,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> phoneNumbers,  List<String> emails,  String? address,  String? company,  String? notes,  DateTime? birthday,  bool isFavorite,  String? profilePicturePath,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumbers,_that.emails,_that.address,_that.company,_that.notes,_that.birthday,_that.isFavorite,_that.profilePicturePath,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Contact extends Contact {
  const _Contact({required this.id, required this.name, final  List<String> phoneNumbers = const [], final  List<String> emails = const [], this.address, this.company, this.notes, this.birthday, this.isFavorite = false, this.profilePicturePath, required this.createdAt, required this.updatedAt}): _phoneNumbers = phoneNumbers,_emails = emails,super._();
  factory _Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

@override final  String id;
@override final  String name;
 final  List<String> _phoneNumbers;
@override@JsonKey() List<String> get phoneNumbers {
  if (_phoneNumbers is EqualUnmodifiableListView) return _phoneNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_phoneNumbers);
}

 final  List<String> _emails;
@override@JsonKey() List<String> get emails {
  if (_emails is EqualUnmodifiableListView) return _emails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emails);
}

@override final  String? address;
@override final  String? company;
@override final  String? notes;
@override final  DateTime? birthday;
@override@JsonKey() final  bool isFavorite;
@override final  String? profilePicturePath;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactCopyWith<_Contact> get copyWith => __$ContactCopyWithImpl<_Contact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contact&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._phoneNumbers, _phoneNumbers)&&const DeepCollectionEquality().equals(other._emails, _emails)&&(identical(other.address, address) || other.address == address)&&(identical(other.company, company) || other.company == company)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.profilePicturePath, profilePicturePath) || other.profilePicturePath == profilePicturePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_phoneNumbers),const DeepCollectionEquality().hash(_emails),address,company,notes,birthday,isFavorite,profilePicturePath,createdAt,updatedAt);

@override
String toString() {
  return 'Contact(id: $id, name: $name, phoneNumbers: $phoneNumbers, emails: $emails, address: $address, company: $company, notes: $notes, birthday: $birthday, isFavorite: $isFavorite, profilePicturePath: $profilePicturePath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$ContactCopyWith(_Contact value, $Res Function(_Contact) _then) = __$ContactCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> phoneNumbers, List<String> emails, String? address, String? company, String? notes, DateTime? birthday, bool isFavorite, String? profilePicturePath, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ContactCopyWithImpl<$Res>
    implements _$ContactCopyWith<$Res> {
  __$ContactCopyWithImpl(this._self, this._then);

  final _Contact _self;
  final $Res Function(_Contact) _then;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phoneNumbers = null,Object? emails = null,Object? address = freezed,Object? company = freezed,Object? notes = freezed,Object? birthday = freezed,Object? isFavorite = null,Object? profilePicturePath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Contact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumbers: null == phoneNumbers ? _self._phoneNumbers : phoneNumbers // ignore: cast_nullable_to_non_nullable
as List<String>,emails: null == emails ? _self._emails : emails // ignore: cast_nullable_to_non_nullable
as List<String>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,profilePicturePath: freezed == profilePicturePath ? _self.profilePicturePath : profilePicturePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
