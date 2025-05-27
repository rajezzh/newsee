import 'dart:convert';

/* 
@author     : ganeshkumar.b 27/05/2025
@desc       : data class for ProductSchemaMasters Model 
@param      : refer ReadMe.MD in feature/masters/Readme.MD
 */
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
// productschema.g.dart is a generated file by jsonserializable which having helper methods
// for json seri deseri
part 'productschema.g.dart';

@JsonSerializable()
class ProductSchemaValues {
  final String optionValue;
  final String optionDesc;
  final String optionId;
  ProductSchemaValues({
    required this.optionValue,
    required this.optionDesc,
    required this.optionId,
  });

  ProductSchemaValues copyWith({
    String? optionValue,
    String? optionDesc,
    String? optionId,
  }) {
    return ProductSchemaValues(
      optionValue: optionValue ?? this.optionValue,
      optionDesc: optionDesc ?? this.optionDesc,
      optionId: optionId ?? this.optionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'optionValue': optionValue,
      'optionDesc': optionDesc,
      'optionId': optionId,
    };
  }

  factory ProductSchemaValues.fromMap(Map<String, dynamic> map) {
    return ProductSchemaValues(
      optionValue: map['optionValue'] as String,
      optionDesc: map['optionDesc'] as String,
      optionId: map['optionId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSchemaValues.fromJson(Map<String, dynamic> json) => _$ProductSchemaValuesFromJson(json);

  @override
  String toString() {
    return 'ProductSchemaValues(optionValue: $optionValue, optionDesc: $optionDesc, optionId: $optionId)';
  }

  @override
  bool operator ==(covariant ProductSchemaValues other) {
    if (identical(this, other)) return true;

    return other.optionValue == optionValue &&
        other.optionDesc == optionDesc &&
        other.optionId == optionId;
  }

  @override
  int get hashCode {
    return optionValue.hashCode ^
        optionDesc.hashCode ^
        optionId.hashCode;
  }
}
