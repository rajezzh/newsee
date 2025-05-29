/* 
@author     : karthick.d  14/05/2025
@desc       : Data class for Login Rest API response json serialization
              json serialization fromJSON and deserialization toJson
              will be delegated to auth_respose_model.g.dart 
              which is a generated file by running 
              dart run build_runner run command
 */
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  @JsonKey(name: 'LPuserID')
  final String id;
  final String UserName;
  final String Orgscode;
  final List<String> orgLocationList;
  final String StatusCode;
  final List<String> UserGroups;
  final String token;
  final MasterDetailsList MasterDetails;

  AuthResponseModel({
    required this.id,
    required this.UserName,
    required this.Orgscode,
    required this.orgLocationList,
    required this.StatusCode,
    required this.UserGroups,
    required this.token,
    required this.MasterDetails,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  @override
  String toString() {
    return 'AuthResponseModel [ id = $id , userName = $UserName]';
  }
}

@JsonSerializable()
class MasterDetailsList {
  final String? DocumentMaster;
  final String? BankMaster;
  final String? IntRateMaster;
  final String? StateCityMaster;
  final String? ProductMaster;
  final String? OrganizationMaster;
  final String? SourcingMaster;
  final String? Listofvalues;
  final String? ProductScheme;

  MasterDetailsList({
    required this.DocumentMaster,
    required this.BankMaster,
    required this.IntRateMaster,
    required this.StateCityMaster,
    required this.ProductMaster,
    required this.OrganizationMaster,
    required this.SourcingMaster,
    required this.Listofvalues,
    required this.ProductScheme,
  });

  factory MasterDetailsList.fromJson(Map<String, dynamic> json) =>
      _$MasterDetailsListFromJson(json);

  Map<String, dynamic> toJson() => _$MasterDetailsListToJson(this);

   bool compareto(lovmaster, productsmaster, productschemamaster) {
    return Listofvalues == lovmaster &&
    ProductMaster == productsmaster &&
    productschemamaster == ProductScheme;
  }
}
