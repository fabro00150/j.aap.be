import 'package:jappbe/config/db_conecction.dart';
import 'package:jappbe/models/medidor_model.dart';
import 'package:jappbe/services/api_service.dart';

class MedidorRepository {
  static String tableName = 'medidor';  

  static Future<List<Medidor>> select() async {
    var result = await ApiService.get_medidores();
    if (result.isEmpty) {
      return List.empty();
    } else {
      return List.generate(result.length, (i) => Medidor.fromJson(result[i]));
    }
  }

  
}
