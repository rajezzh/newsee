import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/masters/domain/modal/master_version.dart';
import 'package:newsee/feature/masters/domain/repository/masterversion_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

/*
  @author     : karthick.d 02/06/62025 
  @desc       : Check login master version and master table version
  @param      : {Map<String, dynamic> source} - masterversionobject from loginapi resp
  @return     : return Future<List<MasterVersion>>
   */

Future<List<MasterVersion>> compareVersions(Map<String, dynamic> source) async {
  // source is a map that is going to be tested against the target

  // step 1 : target map have master version name and version number
  // converted to a iterable of map

  final targetMasterList =
      source.entries
          .map(
            (e) =>
                MasterVersion(mastername: e.key, version: e.value, status: ''),
          )
          .toList();

  Database db = await DBConfig().database;

  // step 2 : masterversion table data collected , which is compared against
  // targetObjList
  List<MasterVersion> masterversionsList =
      await MasterversionCrudRepo(db).getAll();

  // check against targetMaster - if targetMasterList['mastername'] ==  masterversionsList['mastername']
  // check the version if it's equal return else store it in a list

  // list to store all the masters which versio are not equal to the targetMasterList
  // hence this
  List<MasterVersion> differredMasters = [];

  masterversionsList.forEach((e) {
    differredMasters =
        targetMasterList
            .where(
              (v) => (v.mastername == e.mastername) && (v.version != e.version),
            )
            .toList();
  });
  return differredMasters;
}
