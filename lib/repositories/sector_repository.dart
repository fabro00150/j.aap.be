import 'package:jappbe/models/sector_model.dart';
import 'package:jappbe/services/api_service.dart';

class SectorRepository {
  static Future<List<Sector>> getSectores() async {
    try {
      final response = await ApiService.getSectores();
      return response.map((json) => Sector.fromJson(json)).toList();
    } catch (e) {
      print('Error en SectorRepository.getSectores: $e');
      rethrow;
    }
  }

  static Future<Sector> getSectorById(int id) async {
    try {
      final response = await ApiService.getSector(id);
      return Sector.fromJson(response);
    } catch (e) {
      print('Error en SectorRepository.getSectorById: $e');
      rethrow;
    }
  }

  static Future<List<Sector>> select() async {
    try {
      final sectores = await getSectores();
      return sectores;
    } catch (e) {
      print('Error en SectorRepository.select: $e');
    }
    return <Sector>[];
  }
  static Future<int> insert(Sector sector) async {
    try {
      final response = await ApiService.insertSector(sector.toJson());
      return response['id']; // Asumiendo que la API devuelve el ID del nuevo sector
    } catch (e) {
      print('Error en SectorRepository.insert: $e');
      rethrow;
    }
  }
  static Future<int> update(Sector sector) async {
    try {
      final response = await ApiService.updateSector(sector.id!, sector.toJson());
      return response['id']; // Asumiendo que la API devuelve el ID del sector actualizado
    } catch (e) {
      print('Error en SectorRepository.update: $e');
      rethrow;
    }
  }
}
