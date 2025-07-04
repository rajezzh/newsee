import 'package:newsee/feature/auth/domain/model/user/auth_response_model.dart';
import 'package:newsee/feature/masters/domain/modal/master_version.dart';

class Globalconfig {
  static final bool isInitialRoute = false;

  //A global map used to store the latest version of each master data
  //recieved from the server during login activity.

  static Map<String, dynamic> masterVersionMapper = {};

  static List<MasterVersion> diffListOfMaster = [];
}

/* 

call masterVersionService() => { 'version' : ''}

 */
