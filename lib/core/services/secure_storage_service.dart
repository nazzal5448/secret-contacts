import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _encryptionKeyName = 'hive_encryption_key';
  static const String _pinKeyName = 'user_pin_hash';
  static const String _biometricsEnabledKey = 'biometrics_enabled';

  // Get or Generate Encryption Key for Hive
  Future<List<int>> getEncryptionKey() async {
    String? storedKey = await _secureStorage.read(key: _encryptionKeyName);
    
    if (storedKey == null) {
      final key = Hive.generateSecureKey();
      await _secureStorage.write(
        key: _encryptionKeyName,
        value: base64UrlEncode(key),
      );
      return key;
    }
    
    return base64Url.decode(storedKey);
  }

  // PIN Management
  Future<void> savePin(String pin) async {
    final hashedPin = _hashPin(pin);
    await _secureStorage.write(key: _pinKeyName, value: hashedPin);
  }

  Future<bool> hasPin() async {
    final pin = await _secureStorage.read(key: _pinKeyName);
    return pin != null;
  }

  Future<bool> verifyPin(String pin) async {
    final storedHash = await _secureStorage.read(key: _pinKeyName);
    if (storedHash == null) return false;
    
    final inputHash = _hashPin(pin);
    return storedHash == inputHash;
  }

  String _hashPin(String pin) {
    // Simple SHA-256 hash for the PIN
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Biometrics preferences
  Future<void> setBiometricsEnabled(bool enabled) async {
    await _secureStorage.write(
      key: _biometricsEnabledKey,
      value: enabled.toString(),
    );
  }

  Future<bool> isBiometricsEnabled() async {
    final val = await _secureStorage.read(key: _biometricsEnabledKey);
    return val == 'true';
  }
}
