import 'package:jappbe/config/db_conecction.dart';
import 'package:jappbe/models/pagos_model.dart';
import 'package:jappbe/services/api_service.dart';

class PagosRepository {
  static const String tableName = 'pagos';

  static Future<List<Pagos>> select(int lecturaId) async {
    try {
      final response = await ApiService.getPagos(lecturaId);
      return response.map((json) => Pagos.fromJson(json)).toList();
    } catch (e) {
      print('Error en PagosRepository.select: $e');
      rethrow;
    }        
  }


  static Future<int> insert(Pagos pago) async {
    return ApiService.insert_pago(pago.toJson());
  }

  static Future<int> update(Pagos pago) async {
    return ApiService.update_pago(pago.id!, pago.toJson());
  }

  static Future<int> delete(Pagos pago) async {
    return ApiService.delete_pago(pago.id!);
  }
}