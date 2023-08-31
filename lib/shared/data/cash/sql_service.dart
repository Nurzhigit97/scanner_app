import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'products.db'),
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE products(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      barcode TEXT,
      productName TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await database();
    return db.query(table);
  }

  static Future<void> update(String table, Map<String, dynamic> data) async {
    print('barcode ${data['barcode']}');

    final db = await database();
    await db.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
    print('barcode ${data['barcode']}');
  }

  static Future<void> delete(String table, int id) async {
    final db = await database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteAll(String table) async {
    final db = await database();
    await db.delete(table);
  }
}
