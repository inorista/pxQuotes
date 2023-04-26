import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _secureStorage = const FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  Future<void> writeData(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value, aOptions: _getAndroidOptions());
    } catch (e) {
      log("ERROR ${e.toString()}");
    }
  }

  Future<String?> readData(String key) async {
    var data = await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return data;
  }

  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }
}
