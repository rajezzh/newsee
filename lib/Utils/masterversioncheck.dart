import 'package:newsee/AppData/globalconfig.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/auth/domain/model/user/auth_response_model.dart';
import 'package:newsee/feature/masters/domain/modal/master_version.dart';
import 'package:newsee/feature/masters/domain/repository/masterversion_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

 /*
  @author     : ganeshkumar.b 29/05/2025
  @desc       : Check login master version and master table version
  @param      : null
  @return     : return true or
   */

Future<bool> versioncheck() async {
  try {
    Database db = await DBConfig().database;
    MasterversionCrudRepo masterVersionCrudRepo = MasterversionCrudRepo(db);

    List<MasterVersion> getmasterversiondata = [];

    getmasterversiondata = await masterVersionCrudRepo.getAll();

    print("getmasterversiondata $getmasterversiondata");

    final MasterVersion lovmasterversion = getmasterversiondata.firstWhere(
      (item) => item.mastername.contains('Listofvalues'),
    );
    print("masterversionsList.length $lovmasterversion");

    final MasterVersion productmasterversions = getmasterversiondata.firstWhere(
      (item) => item.mastername.contains('ProductMaster'),
    );
    print("masterversionsList.length $lovmasterversion");

    final MasterVersion productschemamasterversions = getmasterversiondata.firstWhere(
      (item) => item.mastername.contains('ProductScheme'),
    );
    print("masterversionsList.length ${lovmasterversion}");

    final Map<String, dynamic> loginMasterVersion = Globalconfig.masterVersionMapper;
    print("Listofvalues is ${loginMasterVersion['Listofvalues']} compare to lovmasterversions is ${lovmasterversion.version}");
    print("ProductMaster is ${loginMasterVersion['ProductMaster']} compare to productmasterversions is ${productmasterversions.version}");
    print("ProductScheme is ${loginMasterVersion['ProductScheme']} compare to productschemamasterversions is ${productschemamasterversions.version}");
    bool lovCompareRes = compareobj(loginMasterVersion, lovmasterversion);
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