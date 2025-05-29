// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      id: json['LPuserID'] as String,
      UserName: json['UserName'] as String,
      Orgscode: json['Orgscode'] as String,
      orgLocationList:
          (json['orgLocationList'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      StatusCode: json['StatusCode'] as String,
      UserGroups:
          (json['UserGroups'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      token: json['token'] as String,
      MasterDetails: MasterDetailsList.fromJson(
        json['MasterDetails'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'LPuserID': instance.id,
      'UserName': instance.UserName,
      'Orgscode': instance.Orgscode,
      'orgLocationList': instance.orgLocationList,
      'StatusCode': instance.StatusCode,
      'UserGroups': instance.UserGroups,
      'token': instance.token,
      'MasterDetails': instance.MasterDetails,
    };

MasterDetailsList _$MasterDetailsListFromJson(Map<String, dynamic> json) =>
    MasterDetailsList(
      DocumentMaster: json['DocumentMaster'] as String,
      BankMaster: json['BankMaster'] as String,
      IntRateMaster: json['IntRateMaster'] as String,
      StateCityMaster: json['StateCityMaster'] as String,
      ProductMaster: json['ProductMaster'] as String,
      OrganizationMaster: json['OrganizationMaster'] as String,
      SourcingMaster: json['SourcingMaster'] as String,
      Listofvalues: json['Listofvalues'] as String,
      ProductScheme: json['ProductScheme'] as String,
    );

Map<String, dynamic> _$MasterDetailsListToJson(MasterDetailsList instance) =>
    <String, dynamic>{
      'DocumentMaster': instance.DocumentMaster,
      'BankMaster': instance.BankMaster,
      'IntRateMaster': instance.IntRateMaster,
      'StateCityMaster': instance.StateCityMaster,
      'ProductMaster': instance.ProductMaster,
      'OrganizationMaster': instance.OrganizationMaster,
      'SourcingMaster': instance.SourcingMaster,
      'Listofvalues': instance.Listofvalues,
      'ProductScheme': instance.ProductScheme,
    };
