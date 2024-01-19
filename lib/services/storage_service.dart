import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();
  final _accountNameController = TextEditingController(text: 'flutter_secure_storage_service');

  /// When using the encryptedSharedPreferences parameter on Android,
  /// make sure to pass the option to the constructor instead of the function like the below:
  /// This will prevent errors due to mixed usage of encryptedSharedPreferences
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
    // sharedPreferencesName: 'abnews',
    // preferencesKeyPrefix: 'ab'
  );

  /// iOS options
  IOSOptions _getIOSOptions() => IOSOptions(
    accountName: _getAccountName(),
  );

  /// Account name for iOS options
  String? _getAccountName() => _accountNameController.text.isEmpty ? null : _accountNameController.text;

  /// Decrypts and returns the value for the given [key] or null if [key] is not in the storage.
  Future<String?> read(String key) async {
    return await _storage.read(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  /// Encrypts and saves the [key] with the given [value].
  ///
  /// If the key was already in the storage, its associated value is changed.
  /// If the value is null, deletes associated value for the given [key].
  Future<void> add(String key, value) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  /// Deletes associated value for the given [key].
  ///
  /// If the given [key] does not exist, nothing will happen.
  Future<void> remove(String key) async {
    await _storage.delete(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }
}
