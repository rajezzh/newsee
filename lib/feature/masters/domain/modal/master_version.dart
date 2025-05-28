/*
@author     : akshayaa.p 28/05/2025
@desc       : data class for MastersVersion model
*/

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'master_version.g.dart';

@JsonSerializable()
class MasterVersion {
  final String mastername;
  final String version;
  final String status;
  MasterVersion({
    required this.mastername,
    required this.version,
    required this.status
  });

  MasterVersion copyWith({
    String? mastername,
    String? version,
    String? status
  }) {
    return MasterVersion(
      mastername: mastername ?? this.mastername,
      version: version ?? this.version,
      status: status ?? this.status
      );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mastername': mastername,
      'version': version,
      'status': status
    };
  }

  factory MasterVersion.fromMap(Map<String, dynamic> map) {
    return MasterVersion(
      mastername: map['mastername'] as String, 
      version: map['version'] as String,
      status: map['status'] as String
      );
  }

  Map<String, dynamic> toJson() => _$MasterVersionToJson(this);

  factory MasterVersion.fromJson(Map<String, dynamic> json) =>
      _$MasterVersionFromJson(json);

  @override
  String toString() {
    return 'MasterVersion(mastername: $mastername, version: $version, status: $status)';
  }

  @override
  bool operator == (covariant MasterVersion other) {
    if(identical(this, other)) return true;

    return other.mastername == mastername &&
          other.version == version &&
          other.status == status;
  }

  @override
  int get hashCode {
    return mastername.hashCode ^
          version.hashCode ^
          status.hashCode;
  }
}