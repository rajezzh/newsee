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
      MasterVersion(mastername: 'Listofvalues', version: '3', status: 'success');
    final MasterVersion productmasterversions = 
      MasterVersion(mastername: 'ProductMaster', version: '3', status: 'success');
    final MasterVersion mainsubproductmasterversions = 
      MasterVersion(mastername: 'MainSubProductMaster', version: '1', status: 'success');
    final MasterVersion productschemamasterversions = 
      MasterVersion(mastername: 'ProductScheme', version: '1', status: 'success');
    final Map<String, dynamic> loginMasterVersion = Globalconfig.masterVersionDetails;
    print("Listofvalues is ${loginMasterVersion['Listofvalues']} compare to lovmasterversions is ${lovmasterversions.version}");
    print("ProductMaster is ${loginMasterVersion['ProductMaster']} compare to productmasterversions is ${productmasterversions.version}");
    print("ProductScheme is ${loginMasterVersion['ProductScheme']} compare to productschemamasterversions is ${productschemamasterversions.version}");
    bool lovCompareRes = compareobj(loginMasterVersion, lovmasterversions);
    print("lovCompareRes $lovCompareRes");
    bool productMasterCompareRes = compareobj(loginMasterVersion, productmasterversions);
    print("productMasterCompareRes $productMasterCompareRes");
    bool productSchemaCompareRes = compareobj(loginMasterVersion, productschemamasterversions);
    print("productSchemaCompareRes $productSchemaCompareRes");
    if (lovCompareRes && productMasterCompareRes && productSchemaCompareRes) {
      return true;
    }
    return false;
  } catch (error) {
    print("master version check is => $error");
    return false;
  }
}

bool compareobj(Map<String, dynamic> obj1, MasterVersion obj2) {
  try {
    for (var key in obj1.keys) {
      if (key == obj2.mastername) {
        if (obj1[key] == obj2.version) {
          return true;
        }
      }
    }
    return false;
  } catch(error) {
    print("compareobj-error $error");
    return false;
  }
  
}

// bool compareObj(Map<String, dynamic> obj1, List obj2) {
//   for (var list in obj2) {
//     print("object 2 list ${list['mastername']}");
//     for (var key in obj1.keys) {
//       print("object 1 Keyname list  $key");
//       if (key == list['mastername']) {
//         print("obect 1 and object 2 is true");
//         print("object 1 key value is ${obj1[key]}");
//         if (obj1[key] == list['version']) {
//           print("succesfully comapred");
//         } else {
//           print("wrong comaparison");
//           return false;
//         }
//       }
//     }
//   }
//   return true;
// }