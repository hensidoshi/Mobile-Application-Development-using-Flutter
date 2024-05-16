import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  String table = "faculty";

  // INITDATABASE Function
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'myfirstdatabase3.db');
    return await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE $table (id TEXT PRIMARY KEY, name TEXT)');
        });
  }

  // COPYTOROOT Function
  Future<bool> copyPasteAssetFileToRoot() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "myfirstdatabase3.db");

      if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
        ByteData data = await rootBundle.load(join('assets/database', 'myfirstdatabase3.db'));
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes);
        return true;
      }
      return false;
    } catch (e) {
      print("Error copying asset file: $e");
      return false;
    }
  }

  Future<List<Map<String, Object?>>> getDataFromfaculty() async {
    Database db = await initDatabase();
    var data = await db.rawQuery("SELECT * FROM $table");
    return data;
  }

  Future<int> deletefaculty(var id) async {
    Database db = await initDatabase();
    var data = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return data;
  }

  Future<int> insertfaculty({required var id, required String name}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = {
      'id': id,
      'name': name,
    };
    var insertedId = await db.insert(table, map);
    return insertedId;
  }

  Future<int> updatefaculty({required var id, required String name}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = {'name': name};
    var data = await db.update(table, map, where: "id = ?", whereArgs: [id]);
    return data;
  }
}