import 'package:newsee/AppData/DBConstants/table_key_masterversion.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/masters/domain/modal/master_version.dart';
import 'package:sqflite/sql.dart';

class MasterversionCrudRepo {
  Future<void> insert (MasterVersion master) async {
    final db = await DBConfig().database;
    await db.insert(
      TableKeyMasterversion.tableName, 
      master.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

   Future<List<MasterVersion>> getAllMasters() async {
    final db = await DBConfig().database;
    final result = await db.query(TableKeyMasterversion.tableName);
    return result.map((e) => MasterVersion.fromMap(e)).toList();
   }
}