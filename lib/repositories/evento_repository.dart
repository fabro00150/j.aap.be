import 'package:jappbe/config/db_conecction.dart';
import 'package:jappbe/models/evento_model.dart';

class EventoRepository {
  static const tableName = 'evento';

  static Future<List<Evento>> select() async {
    var result = await DbConnection.list(tableName);
    if (result.isEmpty) {
      return List.empty();
    } else {
      return List.generate(result.length, (i) => Evento.fromJson(result[i]));
    }
  }

  static Future<int> insert(Evento evento) async {
    return await DbConnection.insert(tableName, evento.toJson());
  }

  static Future<int> update(Evento evento) async {
    return await DbConnection.update(tableName, evento.toJson(), evento.id as int);
  }

  static Future<int> delete(Evento evento) async {
    return await DbConnection.delete(tableName, evento.id as int);
  }

  static Future<Evento?> selectEventoPorId(int eventoId) {
    return DbConnection.selectById(tableName, eventoId).then((result) {
      if (result.isEmpty) {
        return null;
      } else {
        return Evento.fromJson(result.first);
      }
    });
  }
}