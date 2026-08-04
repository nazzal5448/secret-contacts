import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secret_contacts/features/contacts/domain/contact.dart';
import 'package:secret_contacts/features/contacts/domain/contacts_repository.dart';

class HiveContactsRepository implements ContactsRepository {
  static const String _boxName = 'secure_contacts_box';
  late Box<String> _box;
  bool _isInitialized = false;

  @override
  Future<void> init(List<int> encryptionKey) async {
    if (_isInitialized) return;
    _box = await Hive.openBox<String>(
      _boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    _isInitialized = true;
  }

  @override
  Future<List<Contact>> getContacts() async {
    _checkInit();
    final contacts = <Contact>[];
    for (final value in _box.values) {
      final map = jsonDecode(value) as Map<String, dynamic>;
      contacts.add(Contact.fromJson(map));
    }
    return contacts;
  }

  @override
  Future<Contact?> getContact(String id) async {
    _checkInit();
    final value = _box.get(id);
    if (value == null) return null;
    return Contact.fromJson(jsonDecode(value) as Map<String, dynamic>);
  }

  @override
  Future<void> addContact(Contact contact) async {
    _checkInit();
    final value = jsonEncode(contact.toJson());
    await _box.put(contact.id, value);
  }

  @override
  Future<void> updateContact(Contact contact) async {
    _checkInit();
    final value = jsonEncode(contact.toJson());
    await _box.put(contact.id, value);
  }

  @override
  Future<void> deleteContact(String id) async {
    _checkInit();
    await _box.delete(id);
  }

  @override
  Future<void> toggleFavorite(String id) async {
    _checkInit();
    final contact = await getContact(id);
    if (contact != null) {
      final updated = contact.copyWith(isFavorite: !contact.isFavorite);
      await updateContact(updated);
    }
  }

  void _checkInit() {
    if (!_isInitialized) {
      throw Exception('HiveContactsRepository not initialized. Call init() first.');
    }
  }
}
