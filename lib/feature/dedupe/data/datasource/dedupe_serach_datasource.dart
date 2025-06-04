 
import 'package:dio/dio.dart';

class DedupeDataSource {
  final Dio dio;
  DedupeDataSource({required this.dio});
 
 /*
  @author     : ganeshkumar.b 03/06/2025
  @desc       : login api consumer - dio.post method 
                datasource directory encapsulated http services and setup like
                http interceptors etc
  @param      : http request payload
  @return     : Future<Response> Response - > HttpResponse
   */
  dedupeSearchcustomer(payload) async {
    final res = await dio.post(
      'MobileService/getDedupeSearch', 
      data: payload
    );
    // print("REsponse for dedupe $res" );
    return res;
  }
}
 