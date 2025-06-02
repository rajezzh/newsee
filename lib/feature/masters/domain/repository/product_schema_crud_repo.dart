import 'package:newsee/AppData/DBConstants/dbconstants.dart';
import 'package:newsee/AppData/DBConstants/table_key_productschema.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/modal/productschema.dart';
import 'package:newsee/feature/masters/domain/repository/simple_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

class ProductSchemaCrudRepo extends SimpleCrudRepo<ProductSchema> {
  final Database _db;

  ProductSchemaCrudRepo(this._db);

  @override
  Future<int> save(ProductSchema o) async {
    return _db.transaction((txn) async {
      return await txn.insert(
        TableKeysProductSchema.tableName,
        o.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  @override
  Future<int> delete(ProductSchema o) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductSchema>> getAll() async {
    final List<Map<String, dynamic>> data = await _db.query(
      TableKeysProductSchema.tableName,
      orderBy: 'id DESC',
    );
    print("retdata $data");
    return List.generate(data.length, (index) => ProductSchema.fromJson(data[index]));
  }

  @override
  Future<int> update(ProductSchema o) {
    throw UnimplementedError();
  }

}