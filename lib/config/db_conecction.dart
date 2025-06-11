import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static const version = 1;
  static const dbName = "gestion.db";

  static Future<Database> getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE sector(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT UNIQUE,
            descripcion TEXT,
            estado TEXT
          )''');

        await db.execute('''
          CREATE TABLE usuario(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sector_id INTEGER,
            dni_cedula TEXT UNIQUE,
            apellido_paterno TEXT,
            apellido_materno TEXT,
            nombres TEXT,
            telefono TEXT,
            FOREIGN KEY(sector_id) REFERENCES sector(id) ON DELETE CASCADE
          )''');

        await db.execute('''
          CREATE TABLE medidor(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            usuario_id INTEGER,
            numero_serie TEXT UNIQUE,
            coordenadas TEXT,
            fecha_instalacion DATE,
            FOREIGN KEY(usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
          )''');

        await db.execute('''
          CREATE TABLE lectura(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            usuario_id INTEGER,
            fecha DATE,
            consumo INTEGER,
            mes INTEGER,
            FOREIGN KEY(usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
          )''');

        await db.execute('''
          CREATE TABLE evento(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            descripcion TEXT,
            fecha DATETIME,
            lugar TEXT
          )''');

        await db.execute('''
            CREATE TABLE asistencia(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              evento_id INTEGER,
              usuario_id INTEGER,
              fecha_hora DATETIME,
              asistio TEXT DEFAULT 'false',
              FOREIGN KEY(evento_id) REFERENCES evento(id) ON DELETE CASCADE,
              FOREIGN KEY(usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
            )''');

        await db.execute('''
          CREATE TABLE pago(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            usuario_id INTEGER,
            lectura_id INTEGER,
            monto NUMERIC,
            fecha_pago DATE,
            estado TEXT,
            FOREIGN KEY(usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
            FOREIGN KEY(lectura_id) REFERENCES lectura(id) ON DELETE CASCADE
          )''');
        await db.execute('''
          CREATE TRIGGER insert_asistencias_after_evento_insert
          AFTER INSERT ON evento
          BEGIN
            INSERT INTO asistencia (evento_id, usuario_id, fecha_hora, asistio)
            SELECT NEW.id, usuario.id, NEW.fecha, 'false'
            FROM usuario;
          END;
        ''');

        // Datos iniciales
        await db.execute(
          '''INSERT INTO sector (id, nombre, descripcion, estado) 
            VALUES (1, 'Sector 1', 'Zona central', 'true')''',
        );
        await db.execute(
          '''INSERT INTO sector (id, nombre, descripcion, estado) 
            VALUES (2, 'Sector 2', 'Zona norte', 'true')''',
        );
        await db.execute('''INSERT INTO usuario (
          id, 
          dni_cedula, 
          nombres, 
          apellido_paterno, 
          apellido_materno, 
          telefono, 
          sector_id) 
            VALUES (
            1, 
            '9999999999', 
            'Usuario Demo', 
            'Demo_paterno', 
            'Demo_materno',
            '08654321', 
            1)''');
        await db.execute('''INSERT INTO medidor (
          id, 
          usuario_id, 
          numero_serie, 
          coordenadas, 
          fecha_instalacion) 
            VALUES (
            1, 
            1, 
            '1234567890', 
            '0,0', 
            '2022-01-01')''');
      },
      version: version,
    );
  }

  static Future<int> insert(String tableName, dynamic data) async {
    // obtener la configuracion de la base de datos
    final db = await getDb();
    return db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> update(String tableName, dynamic data, int id) async {
    // obtener la configuracion de la base de datos
    final db = await getDb();
    //consumo de la funcion del orm
    return db.update(
      tableName,
      data,
      where: 'id=?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> delete(String tableName, int id) async {
    // obtener la configuracion de la base de datos
    final db = await getDb();
    //consumo de la funcion del orm
    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> list(String tableName) async {
    // obtener la configuracion de la bdd
    final db = await getDb();
    return db.query(tableName);
  }

  static Future<List<Map<String, dynamic>>> filter(
    String tableName,
    String where,
    dynamic whereArgs,
  ) async {
    // obtener la configuracion de la bdd
    final db = await getDb();
    return db.query(tableName, where: where, whereArgs: whereArgs);
  }

  static Future<List<Map<String, dynamic>>> selectById(
    String tableName,
    int id,
  ) async {
    // obtener la configuracion de la bdd
    final db = await getDb();
    return db.query(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
