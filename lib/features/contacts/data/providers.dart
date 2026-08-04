import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_contacts/core/services/providers.dart';
import 'package:secret_contacts/features/contacts/data/hive_contacts_repository.dart';
import 'package:secret_contacts/features/contacts/domain/contacts_repository.dart';

final contactsRepositoryProvider = Provider<ContactsRepository>((ref) {
  return HiveContactsRepository();
});

// A FutureProvider to initialize the repository when the vault is unlocked
final initContactsRepositoryProvider = FutureProvider<void>((ref) async {
  final secureStorage = ref.read(secureStorageServiceProvider);
  final encryptionKey = await secureStorage.getEncryptionKey();
  
  final repo = ref.read(contactsRepositoryProvider);
  await repo.init(encryptionKey);
});

// Provider to get all contacts
final contactsProvider = FutureProvider((ref) async {
  // Ensure the repository is initialized
  await ref.watch(initContactsRepositoryProvider.future);
  
  final repo = ref.watch(contactsRepositoryProvider);
  return repo.getContacts();
});
