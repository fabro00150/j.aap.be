import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
       // uni 172.16.115.18
      "http://172.16.115.18:8000"; // Depende donde trabajo casa 192.168.0.3 

  static Future<List<dynamic>> getSectores() async {
    final response = await http.get(Uri.parse('$baseUrl/sectores/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar sectores: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getSector(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/sectores/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar sector: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> insertSector(
    Map<String, dynamic> sector,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sectores/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(sector),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al insertar sector: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateSector(
    int id,
    Map<String, dynamic> sector,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/sectores/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(sector),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al actualizar sector: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar usuarios: ${response.statusCode}');
    }
  }

  static Future<int> insertUsuario(Map<String, dynamic> usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Error al insertar usuario: ${response.statusCode}');
    }
  }

  static Future<int> updateUsuario(int id, Map<String, dynamic> usuario) async {
    final response = await http.put(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Error al actualizar usuario: ${response.statusCode}');
    }
  }

  static Future<int> deleteUsuario(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/usuarios/$id'));
    if (response.statusCode == 204) {
      return id; // Retorna el ID del usuario eliminado
    } else {
      throw Exception('Error al eliminar usuario: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getUsuariosPorEvento(int eventoId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usuarios/evento/$eventoId'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Error al cargar usuarios por evento: ${response.statusCode}',
      );
    }
  }

  static Future<int> insert_asistencia(Map<String, dynamic> asistencia) async {
    final response = await http.post(
      Uri.parse('$baseUrl/asistencias/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(asistencia),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Error al insertar asistencia: ${response.statusCode}');
    }
  }

  static Future<int> update_asistencia(
    int id,
    Map<String, dynamic> asistencia,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/asistencias/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(asistencia),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Error al actualizar asistencia: ${response.statusCode}');
    }
  }

  static Future<int> delete_asistencia(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/asistencias/$id'));
    if (response.statusCode == 204) {
      return id; // Retorna el ID de la asistencia eliminada
    } else {
      throw Exception('Error al eliminar asistencia: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getPagos(int lecturaId) async {
    final response = await http.get(Uri.parse('$baseUrl/pagos/$lecturaId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Error al cargar asistencias por evento: ${response.statusCode}',
      );
    }
  }

  static Future<int> insert_pago(Map<String, dynamic> pago) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pagos/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pago),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Error al insertar asistencia: ${response.statusCode}');
    }
  }

  static Future<int> update_pago(int id, Map<String, dynamic> pago) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pagos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pago),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Error al actualizar asistencia: ${response.statusCode}');
    }
  }

  static Future<int> delete_pago(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pagos/$id'));
    if (response.statusCode == 204) {
      return id; // Retorna el ID de la asistencia eliminada
    } else {
      throw Exception('Error al eliminar asistencia: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> get_asistencias() async {
    final response = await http.get(Uri.parse('$baseUrl/asistencias/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar asistencias: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> get_medidores() async {
    final response = await http.get(Uri.parse('$baseUrl/medidores/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar medidores: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> get_asistencias_by_evento(int eventoId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/asistencias/evento/$eventoId'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Error al cargar asistencias por evento: ${response.statusCode}',
      );
    }
  }
}
