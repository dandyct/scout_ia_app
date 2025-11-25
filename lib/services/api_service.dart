import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.0.20:8000";

  static Future<double> predictScore(Map<String, dynamic> playerData) async {
    final url = Uri.parse("$baseUrl/predict");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(playerData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["PredictedScore"]; // backend usa Mayúscula
    } else {
      throw Exception("Error en predicción: ${response.body}");
    }
  }

  static Future<List<dynamic>> topPlayers({int limit = 10}) async {
    final url = Uri.parse("$baseUrl/players/top?limit=$limit");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error obteniendo jugadores top: ${response.body}");
    }
  }
}