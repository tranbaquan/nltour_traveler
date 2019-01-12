import 'dart:io';

import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory document = await getApplicationDocumentsDirectory();
    String path = join(document.path, 'nltraveler.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Traveler ("
          "first_name TEXT,"
          "last_name TEXT,"
          "personal_id TEXT,"
          "email TEXT PRIMARY KEY,"
          "gender INTEGER,"
          "avatar TEXT,"
          "phone_number TEXT,"
          "dob TEXT,"
          "country TEXT,"
          "main_language TEXT,"
          "passport TEXT,"
          ")");
    });
  }

  addTraveler(Traveler traveler) async {
    final db = await database;

    var data = await db.insert("Traveler", traveler.toDBMap());
    return data;
  }

  updateTraveler(Traveler traveler) async {
    final db = await database;
    var res = await db.update("Traveler", traveler.toDBMap(),
        where: "email = ?", whereArgs: [traveler.email]);
    return res;
  }

  getTraveler(String email) async {
    final db = await database;
    var res = await db.query("Traveler", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? Traveler.fromDBMap(res.first) : null;
  }

  deleteTraveler(String email) async {
    final db = await database;
    return db.delete("Traveler", where: "email = ?", whereArgs: [email]);
  }

  deleteAll() async {
    final db = await database;
    return db.rawDelete("Delete * from Traveler");
  }

}
