import 'package:secret_contacts/features/contacts/domain/contact.dart';

abstract class ContactsRepository {
  Future<void> init(List<int> encryptionKey);
  Future<List<Contact>> getContacts();
  Future<Contact?> getContact(String id);
  Future<void> addContact(Contact contact);
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(String id);
  Future<void> toggleFavorite(String id);
}
