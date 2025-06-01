import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "https://seu-servidor-api.com"; // Substitua pelo URL da API

  Future<bool> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "senha": senha}),
    );

    if (response.statusCode == 200) {
      return true; // Sucesso no login
    } else {
      return false; // Falha no login
    }
  }
}
