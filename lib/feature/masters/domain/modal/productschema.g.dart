// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productschema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSchemaValues _$ProductSchemaValuesFromJson(Map<String, dynamic> json) =>
    ProductSchemaValues(
      optionValue: json['optionValue'] as String,
      optionDesc: json['optionDesc'] as String,
      optionId: json['optionId'] as String,
    );

Map<String, dynamic> _$ProductSchemaValuesToJson(
  ProductSchemaValues instance,
) => <String, dynamic>{
  'optionValue': instance.optionValue,
  'optionDesc': instance.optionDesc,
  'optionId': instance.optionId,
};
