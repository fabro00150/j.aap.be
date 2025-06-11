import '../config/db_conecction.dart';
import '../models/usuario_model.dart';
import '../services/api_service.dart';

class UsuarioRepository {

  static Future<int> insert(Usuario usuario) async {
    try {
      return await ApiService.insertUsuario(usuario.toJson());
    } catch (e) {
      print('Error en UsuarioRepository.insert: $e');
      rethrow;
    }
    
  }

  static Future<int> update(Usuario usuario) async {
    try {
      return await ApiService.updateUsuario(usuario.id!, usuario.toJson());
    } catch (e) {
      print('Error en UsuarioRepository.update: $e');
      rethrow;
    }
    
  }

  static Future<int> delete(Usuario usuario) async {
    try {
      return await ApiService.deleteUsuario(usuario.id!);
    } catch (e) {
      print('Error en UsuarioRepository.delete: $e');
      rethrow;
    }
    
  }

  static Future<List<Usuario>> select() async {
    try {
      final response = await ApiService.getUsuarios();
      return response.map((json) => Usuario.fromJson(json)).toList();
    } catch (e) {
      print('Error en UsuarioRepository.select: $e');
      rethrow;
    }
    
    
  }

  static Future<List<Usuario>> selectUsuariosPorEvento(int eventoId) async {
    try {
      final response = await ApiService.getUsuariosPorEvento(eventoId);
      return response.map((json) => Usuario.fromJson(json)).toList();
    } catch (e) {
      print('Error en UsuarioRepository.selectUsuariosPorEvento: $e');
      rethrow;
    }
    
    
  }
}
