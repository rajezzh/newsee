import 'package:newsee/AppData/DBConstants/dbconstants.dart';
import 'package:newsee/AppData/DBConstants/table_key_productschema.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/modal/productschema.dart';
import 'package:newsee/feature/masters/domain/repository/simple_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

class ProductSchemaCrudRepo extends SimpleCrudRepo<ProductSchemaValues> {
  final Database _db;

  ProductSchemaCrudRepo(this._db);

  // @override
  // Future<int> save(ProductSchemaValues o) async {
  //   await _db.transaction((txn) async {
  //     return await _db.insert(
  //       TableKeysProductSchema.tableName, 
  //       o.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace
  //     );
  //   });
  // }
    @override
  Future<int> save(ProductSchemaValues o) async {
    return _db.transaction((txn) async {
      return await txn.insert(
        TableKeysProductSchema.tableName,
        o.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  @override
  Future<int> delete(ProductSchemaValues o) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ProductSchemaValues>> getAll() async {
    final List<Map<String, dynamic>> data = await _db.query(
      TableKeysProductSchema.tableName,
      orderBy: 'id DESC',
    );
    print("retdata $data");
    return List.generate(data.length, (index) => ProductSchemaValues.fromJson(data[index]));
  }

  @override
  Future<int> update(ProductSchemaValues o) {
    // TODO: implement update
    throw UnimplementedError();
  }

}