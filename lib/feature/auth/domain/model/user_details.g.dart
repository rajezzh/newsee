// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
  LPuserID: json['LPuserID'] as String,
  UserName: json['UserName'] as String,
  Orgscode: json['Orgscode'] as String,
  OrgLevel: json['OrgLevel'] as String,
  OrgName: json['OrgName'] as String,
);

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'LPuserID': instance.LPuserID,
      'UserName': instance.UserName,
      'Orgscode': instance.Orgscode,
      'OrgLevel': instance.OrgLevel,
      'OrgName': instance.OrgName,
    };
