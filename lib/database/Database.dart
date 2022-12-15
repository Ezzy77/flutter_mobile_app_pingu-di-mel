import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;


class DatabaseHelper{
  static Future<void> createTables(sql.Database database) async{
    await database.execute('''CREATE TABLE coqueiros(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      firstName Text NOT NULL,
      lastName TEXT NOT NULL,
      dateAdded TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    
    ''');
  }

  // initializing the database
  static Future<sql.Database> db() async{
    return sql.openDatabase(
      'pingo.db',
      version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTables(database);
      },
    );
  }

  // creating a coqueiro
  static Future<int> createCoqueiro(String? firstName, String? lastName) async{
    final db = await DatabaseHelper.db();
    final data = {'firstName':firstName, 'lastName':lastName};
    final id = await db.insert('coqueiros', data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  // getting all coqueiro
  static Future<List<Map<String, dynamic>>> getCoqueiros() async{
    final db = await DatabaseHelper.db();
    return db.query('coqueiros', orderBy: "id");
  }

  // getting single coqueiro
  static Future<List<Map<String, dynamic>>> getSingleCoqueiro(int id) async{
    final db = await DatabaseHelper.db();
    return db.query('coqueiros',where: "id = ?",whereArgs: [id], limit: 1);
  }

  // updating coqueiro detail
 static Future<int> updateCoqueiro(
     int id, String firstName, String lastName
     ) async{
    final db = await DatabaseHelper.db();

    final data ={
      'firstName': firstName,
      'lastName':lastName,
      'dateAdded': DateTime.now().toString()
    };

    final result = await db.update('coqueiros', data, where: "id = ?",
        whereArgs: [id]);
    return result;
 }

 // deleting a coqueiro
 static Future<void> deleteCoqueiro(int id) async{
    final db = await DatabaseHelper.db();

    try{
      await db.delete('coqueiros', where: "id=?", whereArgs: [id]);
    }catch(err){
      debugPrint("something went wrong when deleting an item: $err");
    }
 }



}







// class DataBase {
//   Future<Database> initializedDB() async {
//     String path = await getDatabasesPath();
//     return openDatabase(
//       join(path, 'planets.db'),
//       version: 1,
//       onCreate: (Database db, int version) async {
//         await db.execute(
//           "CREATE TABLE coqueiros(id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT NOT NULL,lastName INTEGER NOT NULL)",
//         );
//       },
//     );
//   }
//
// // insert data
//   Future<int> insertCoqueiro(List<Coqueiros> coqueiros) async {
//     int result = 0;
//     final Database db = await initializedDB();
//     for (var coqueiro in coqueiros) {
//       result = await db.insert('coqueiros', coqueiro.toMap(),
//           conflictAlgorithm: ConflictAlgorithm.replace);
//     }
//
//     return result;
//   }
//
// // retrieve data
//   Future<List<Coqueiros>> retrieveCoqueiros() async {
//     final Database db = await initializedDB();
//     final List<Map<String, Object?>> queryResult = await db.query('coqueiros');
//     return queryResult.map((e) => Coqueiros.fromMap(e)).toList();
//   }
//
// // delete user
//   Future<void> deleteCoqueiro(int id) async {
//     final db = await initializedDB();
//     await db.delete(
//       'coqueiros',
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }
// }



