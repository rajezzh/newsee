/* 
@author     : karthick.d 23/05/2025
@desc       : data class for LovMasters Model 
@param      : refer ReadMe.MD in feature/masters/Readme.MD
 */
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
// lov.g.dart is a generated file by jsonserializable which having helper methods
// for json seri deseri
part 'lov.g.dart';

@JsonSerializable()
class Lov {
  final String Header;
  final String optvalue;
  final String optDesc;
  Lov({required this.Header, required this.optvalue, required this.optDesc});

  Lov copyWith({String? Header, String? optvalue, String? optDesc}) {
    return Lov(
      Header: Header ?? this.Header,
      optvalue: optvalue ?? this.optvalue,
      optDesc: optDesc ?? this.optDesc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Header': Header,
      'optvalue': optvalue,
      'optDesc': optDesc,
    };
  }

  factory Lov.fromMap(Map<String, dynamic> map) {
    return Lov(
      Header: map['Header'] as String,
      optvalue: map['optvalue'] as String,
      optDesc: map['optDesc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lov.fromJson(Map<String, dynamic> json) => _$LovFromJson(json);

  @override
  String toString() =>
      'Lov(Header: $Header, optvalue: $optvalue, optDesc: $optDesc)';

  @override
  bool operator ==(covariant Lov other) {
    if (identical(this, other)) return true;

    return other.Header == Header &&
        other.optvalue == optvalue &&
        other.optDesc == optDesc;
  }

  @override
  int get hashCode => Header.hashCode ^ optvalue.hashCode ^ optDesc.hashCode;
}
