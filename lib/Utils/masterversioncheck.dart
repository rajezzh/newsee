import 'package:newsee/Model/login_response.dart';

class MasterVersion {
  final String mastername;
  final String version;
  final String status;
  MasterVersion(this.mastername, this.version, this.status);

  bool compareto(name, version) {
    return mastername == mastername &&
    version == version;
  }
} 

bool versioncheck(LoginResponse response) {
  try {
    MasterVersion masterVersion = MasterVersion("ganesh", "6", "success");
    bool result = masterVersion.compareto(response.username, response.userId);
    return result;
  } catch (error) {
    print("master version check is => $error");
    return false;
  }
}