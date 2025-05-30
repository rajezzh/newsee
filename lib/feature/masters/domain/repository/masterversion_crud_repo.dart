import 'package:newsee/AppData/DBConstants/table_key_masterversion.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/masters/domain/modal/master_version.dart';
import 'package:sqflite/sqflite.dart';

class MasterversionCrudRepo {
  final Database db;

  MasterversionCrudRepo(this.db);

  Future<void> insert(MasterVersion version) async {
    await db.insert('masterversion', version.toMap());
  }

  Future<void> update(MasterVersion version) async {
    await db.update(
      'masterversion',
      version.toMap(),
      where: 'mastername',
      whereArgs: [version.mastername],
    );
  }

  Future<List<MasterVersion>> getAllMasters() async {
    final _db = await DBConfig().database;
    final List<Map<String,dynamic>> result = await _db.query(TableKeyMasterversion.tableName);
    return result.map((e) => MasterVersion.fromMap(e)).toList();
  }
}
