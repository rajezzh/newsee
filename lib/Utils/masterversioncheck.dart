import 'package:newsee/AppData/globalconfig.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/auth/domain/model/user/auth_response_model.dart';
import 'package:newsee/feature/masters/domain/repository/lov_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

class MasterVersion {
  final String mastername;
  final String version;
  final String status;
  MasterVersion({required this.mastername, required this.version, required this.status});

  MasterVersion copyWith({
    String? mastername,
    String? version,
    String? status,
  }) {
    return MasterVersion(
      mastername: mastername ?? this.mastername,
      version: version ?? this.version,
      status: status ?? this.status,
    );
  }
} 

Future<bool> versioncheck() async {
  try {
    // Database db = await DBConfig().database;
    // LovCrudRepo lovCrudRepo = LovCrudRepo(db);

    final List<MasterVersion> masterversionsList = [];

    final MasterVersion lovmasterversions = 
      MasterVersion(mastername: 'LovMaster', version: '3', status: 'success');
    final MasterVersion productmasterversions = 
      MasterVersion(mastername: 'ProductMaster', version: '3', status: 'success');
    final MasterVersion mainsubproductmasterversions = 
      MasterVersion(mastername: 'MainSubProductMaster', version: '3', status: 'success');
    final MasterVersion productschemamasterversions = 
      MasterVersion(mastername: 'ProductSchemaMaster', version: '4', status: 'success');
    Map<String,dynamic> obj1 = {};

    final MasterDetailsList loginMasterVersion = Globalconfig.masterVersionDetails;
    print("Listofvalues is ${loginMasterVersion.Listofvalues} compare to lovmasterversions is ${lovmasterversions.version}");
    print("ProductMaster is ${loginMasterVersion.ProductMaster} compare to productmasterversions is ${productmasterversions.version}");
    print("ProductScheme is ${loginMasterVersion.ProductScheme} compare to productschemamasterversions is ${productschemamasterversions.version}");
    final masterVersionCheckResponse = loginMasterVersion.compareto(lovmasterversions.version, productmasterversions.version, productschemamasterversions.version);
    return masterVersionCheckResponse;
  } catch (error) {
    print("master version check is => $error");
    return false;
  }
}