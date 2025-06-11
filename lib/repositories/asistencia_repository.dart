import 'package:jappbe/config/db_conecction.dart';
import 'package:jappbe/models/asistencia_model.dart';
import 'package:jappbe/services/api_service.dart';


class AsistenciaRepository {
  static const tableName = 'asistencia';

  static Future<List<Asistencia>> select() async {
    var result = await ApiService.get_asistencias();
    if (result.isEmpty) {
      return List.empty();
    } else {
      return List.generate(result.length, (i) => Asistencia.fromJson(result[i]));
    }
  }
  
  static Future<int> insert(Asistencia asistencia) async {
    return ApiService.insert_asistencia(asistencia.toJson());
  }

  static Future<int> update(Asistencia asistencia) async {
    return ApiService.update_asistencia(asistencia.id!, asistencia.toJson());
  }

  static Future<int> delete(Asistencia asistencia) async {
    return ApiService.delete_asistencia(asistencia.id!);
  }
  
  static Future<List<Asistencia>> selectByEvento(int eventoId) async {
    var result = await ApiService.get_asistencias_by_evento(eventoId);
    if (result.isEmpty) {
      return List.empty();
    } else {
      return List.generate(result.length, (i) => Asistencia.fromJson(result[i]));
    }
  }
}
