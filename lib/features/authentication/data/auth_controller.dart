import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_contacts/core/services/providers.dart';
import 'package:local_auth/local_auth.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref);
});

class AuthController {
  final Ref _ref;
  final LocalAuthentication _localAuth = LocalAuthentication();

  AuthController(this._ref);

  Future<void> setupPin(String pin) async {
    final secureStorage = _ref.read(secureStorageServiceProvider);
    await secureStorage.savePin(pin);
    // Setup encryption key for Hive boxes during first time setup
    await secureStorage.getEncryptionKey();
  }

  Future<bool> verifyPin(String pin) async {
    final secureStorage = _ref.read(secureStorageServiceProvider);
    return await secureStorage.verifyPin(pin);
  }

  Future<bool> hasPinSetup() async {
    final secureStorage = _ref.read(secureStorageServiceProvider);
    return await secureStorage.hasPin();
  }

  Future<bool> canUseBiometrics() async {
    final canCheck = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    return canCheck || isDeviceSupported;
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      final secureStorage = _ref.read(secureStorageServiceProvider);
      final biometricsEnabled = await secureStorage.isBiometricsEnabled();
      
      if (!biometricsEnabled) return false;

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Unlock Secret Contacts Vault',
      );
      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }

  Future<void> setBiometricsEnabled(bool enabled) async {
    final secureStorage = _ref.read(secureStorageServiceProvider);
    await secureStorage.setBiometricsEnabled(enabled);
  }
}
