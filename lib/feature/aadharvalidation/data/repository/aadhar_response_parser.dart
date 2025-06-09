import 'package:dio/dio.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_response.dart';

class AadharResponseParser {
  AadharvalidateResponse parseResponse(Response response) {
    final setupmaster = response.data['responseData']['data'];
    print('AadharResponseParser-----------$setupmaster');
    return AadharvalidateResponse.fromJson(setupmaster);
  }
}
