import 'package:newsee/feature/auth/domain/model/user/auth_response_model.dart';

class Globalconfig {
  static final bool isInitialRoute = false;
  static MasterDetailsList masterVersionDetails = MasterDetailsList(
    DocumentMaster: null,
    BankMaster: null,
    IntRateMaster: null,
    StateCityMaster: null,
    ProductMaster: null,
    OrganizationMaster: null,
    SourcingMaster: null,
    Listofvalues: null,
    ProductScheme: null
  );
}


/* 

call masterVersionService() => { 'version' : ''}

 */