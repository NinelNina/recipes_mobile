import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<void> saveUsername(String username) async {
    await _secureStorage.write(key: 'username', value: username);
  }

  Future<void> saveRole(String role) async {
    await _secureStorage.write(key: 'role', value: role);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<String?> getUsername() async {
    return await _secureStorage.read(key: 'username');
  }

  Future<String?> getRole() async {
    return await _secureStorage.read(key: 'role');
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  Future<void> deleteUsername() async {
    await _secureStorage.delete(key: 'username');
  }

  Future<void> deleteRole() async {
    await _secureStorage.delete(key: 'role');
  }
}
