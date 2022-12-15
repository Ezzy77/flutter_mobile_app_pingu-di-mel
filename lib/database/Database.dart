import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'coqueiro_model.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'planets.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE coqueiros(id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT NOT NULL,lastName INTEGER NOT NULL)",
        );
      },
    );
  }

// insert data
  Future<int> insertCoqueiro(List<Coqueiros> coqueiros) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var coqueiro in coqueiros) {
      result = await db.insert('coqueiros', coqueiro.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

// retrieve data
  Future<List<Coqueiros>> retrieveCoqueiros() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('coqueiros');
    return queryResult.map((e) => Coqueiros.fromMap(e)).toList();
  }

// delete user
  Future<void> deleteCoqueiro(int id) async {
    final db = await initializedDB();
    await db.delete(
      'coqueiros',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
