import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ApiManager {
  final String baseUrl;
  final storage = FlutterSecureStorage();

  ApiManager({required this.baseUrl});

  Future<void> addKost(
  String name,
  String type,
  String photo,
  String location,
  String price,
  String facilities,
) async {
  
    final response = await http.post(
      Uri.parse('$baseUrl/kosts'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': name,
        'type': type,
        'photo': photo,
        'location': location,
        'price': price,
        'facilities': facilities,
      },
    );

    print(response);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to add kost');
    }
  
}


  Future<void> addKostt(
    String name,
    String type,
    String photo,
    String location,
    String price,
    String facilities,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_kost.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': name,
        'type': type,
        'photo': photo,
        'location': location,
        'price': price,
        'facilities': facilities,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add kost');
    }
  }

  Future<List<Map<String, dynamic>>> getKosts() async {
    final response = await http.get(Uri.parse('$baseUrl/kost'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      throw Exception('Failed to get kosts');
    }
  }

  Future<void> updateKost(String id, String name, String type, String photo, String location, String price, String facilities) async {
    final response = await http.put(
      Uri.parse('$baseUrl/kosts/{id}'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id': id,
        'name': name,
        'type': type,
        'photo': photo,
        'location': location,
        'price': price,
        'facilities': facilities,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update kost');
    }
  }

  Future<int?> deleteKost(int id) async {
    final token = await storage.read(key: 'kode_rahassia');
     final response = await http.delete(
      Uri.parse('$baseUrl/kosts'),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode({'id': id}), 
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete kost ${token}');
    }
    else{
      return response.statusCode;
    }
  }

  Future<void> updateUser(String name, String email, String password) async {
  final response = await http.put(
    Uri.parse(baseUrl+'api/update_user'), // Ganti dengan URL endpoint yang sesuai
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${await storage.read(key: 'kode_rahassia')}', // Ambil token autentikasi
    },
    body: {
      'name': name,
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update user');
  }
}

  Future<String?> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl+'api/register'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': name,
        'email': email,
        'password': password
      },
    );

    if (response.statusCode == 200) {
      final token = "Succesfully";
      return token;
    } else {
      throw Exception('Failed to register, email sudah tersedia ${response.statusCode}');

    }
  }


  Future<dynamic?> authenticate(String name, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl+'api/login'),
      body: {'name': name, 'password': password},
    );
    
    print(response.statusCode );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];
      final role = jsonResponse['role'];

      // Save the token securely
      await storage.write(key: 'kode_rahassia', value: token);

      return {
          'token': token,
          'role': role,
        };
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}