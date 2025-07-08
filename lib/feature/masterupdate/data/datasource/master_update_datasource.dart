import 'package:dio/dio.dart';
import 'package:newsee/core/api/api_config.dart';
// import 'package:newsee/feature/masters/domain/modal/master_request.dart';

class MasterUpdateDatasource {
  final Dio dio;

  MasterUpdateDatasource({required this.dio});

  // /*
  // @author     : karthick.d 14/05/2025
  // @desc       : login api consumer - dio.post method 
  //               datasource directory encapsulated http services and setup like
  //               http interceptors etc
  // @param      : http request payload
  // @return     : Future<Response> Response - > HttpResponse
  //  */
  downloadMasterVersion(payload) async {
    Response response = await dio.post(
      ApiConfig.GET_MASTERS_VERSION_API_ENDPOINT,
      data: payload
    );
    return response;
  }

  // downloadMasterOffline() async {
  //   dio.options.baseUrl = 'http://jsonplaceholder.typicode.com/';
  //   Response response = await dio.get('posts');
  //   return response;
  // }
}

/* we need a class with method that connect to local json data source when offline */
