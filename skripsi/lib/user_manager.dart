import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserManager extends ChangeNotifier {
  final storage = FlutterSecureStorage();
  String? authToken;
  String? username;

  Future<void> setAuthToken(String? token) async {
    authToken = token;
    if (token == null) {
      // Hapus token dari penyimpanan lokal saat logout
      await storage.delete(key: 'kode_rahassia');
    } else {
      // Simpan atau perbarui token ke penyimpanan lokal saat login
      await storage.write(key: 'kode_rahassia', value: token);
    }
    notifyListeners();
  }

  Future<void> setUsername(String? name) async {
    username = name;
    if (name == null) {
      await storage.delete(key: 'username'); // Hapus username dari penyimpanan
    } else {
      await storage.write(key: 'username', value: name); // Simpan username ke penyimpanan
    }
    notifyListeners();
  }

  Future<void> logout() async {
    // Hapus token dari penyimpanan lokal saat logout
    await storage.delete(key: 'kode_rahassia');
    authToken = null;
    notifyListeners();
  }

  Future<void> loadUserData() async {
    authToken = await storage.read(key: 'kode_rahassia');
    username = await storage.read(key: 'username');
    notifyListeners();
  }

  bool get isAuthenticated => authToken != null;
}