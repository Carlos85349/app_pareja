import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CartasService {
  Future<List<Map<String, dynamic>>> fetchCartas() async {
    try {
      // Leer el archivo desde assets
      final String data = await rootBundle.loadString('assets/data/cartas.json');
      final List<dynamic> jsonResult = json.decode(data);
      return List<Map<String, dynamic>>.from(jsonResult);
    } catch (e) {
      print("Error leyendo cartas locales: $e");
      return [];
    }
  }
}
