import 'package:jappbe/config/db_conecction.dart';
import 'package:jappbe/models/lectura_model.dart';
import 'package:jappbe/models/sector_model.dart';
import 'package:jappbe/models/usuario_model.dart';

class LecturaRepository {

  static const tableName = 'lectura';

  static Future<List<Lectura>> select() async {
    var result = await DbConnection.list(tableName);
    if (result.isEmpty) {
      return List.empty();
    } else {
      return List.generate(result.length, (i) => Lectura.fromJson(result[i]));
    }
  }

  static Future<int> insert(Lectura lectura) async {
    return await DbConnection.insert("lectura", lectura.toJson());
  }

  static Future<int> update(Lectura lectura) async {
    return await DbConnection.update("lectura", lectura.toJson(), lectura.id as int);
  }

  static Future<int> delete(Lectura lectura) async {
    return await DbConnection.delete("lectura", lectura.id as int);
  }

  static Future<Map<Sector, List<Usuario>>> selectSectoresUsuarios() async {
   
    return <Sector, List<Usuario>>{};
  }
}

