import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  SecureStorageService._internal();

  final _storage = FlutterSecureStorage();

  void addItem(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String> getItem(String key)  async {
    return await _storage.read(key: key);
  }

  void deleteItem(String key) async {
    _storage.delete(key: key);
  }
}