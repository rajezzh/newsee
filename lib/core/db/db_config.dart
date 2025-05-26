/* 
@author     : karthick.d  26/05/2025
@desc       : configure sqlite database 
              create database return db instance
              dbinstance 
 */

import 'package:newsee/AppData/DBConstants/dbconstants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConfig {
  static final DBConfig _instance = DBConfig._();
  factory DBConfig() => _instance;
  static Database? _database;

  DBConfig._() {
    _initDB();
  }

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DbKeys.dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    try {
      const sqlQuery = '''
                CREATE TABLE IF NOT EXISTS ${TableKeysLov.tableName}(
            ${TableKeysLov.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${TableKeysLov.header} TEXT,
            ${TableKeysLov.optValue} TEXT,
            ${TableKeysLov.optDesc} TEXT,
            ${TableKeysLov.optCode} TEXT,
            ${TableKeysLov.version} TEXT
                      )

     ''';
      await db.execute(sqlQuery);
      print('create table success => ${TableKeysLov.tableName} ');
    } catch (e) {
      print('create table error => ${e.toString()} ');
    }
  }
}
