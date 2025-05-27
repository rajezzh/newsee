
import 'package:dio/dio.dart';
import 'package:newsee/feature/masters/domain/modal/productschema.dart';
import 'package:newsee/feature/masters/domain/repository/masters_response_parser.dart';

class ProductschemaParserImpl implements MastersResponseParser<ProductSchemaValues> {
  @override
  List<ProductSchemaValues> parseResponse(Response response) {
    final setupmaster = response.data['Setupmaster'];
    if (setupmaster != null && setupmaster['ProductScheme'] != null) {
      List<dynamic> listofvalues = setupmaster['ProductScheme'];
      List<ProductSchemaValues> productschemaList = listofvalues.map((e) => ProductSchemaValues.fromMap(e)).toList();
      return productschemaList;
    } else {
      List<ProductSchemaValues> productschemaList = [];
      return productschemaList;
    }
  }
}