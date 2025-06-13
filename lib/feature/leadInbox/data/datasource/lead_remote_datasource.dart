import 'package:dio/dio.dart';
import 'package:newsee/core/api/api_config.dart';

class LeadRemoteDatasource {
  final Dio dio;
  LeadRemoteDatasource({required this.dio});

  Future<Response> searchLead(Map<String, dynamic> payload) async {
    return await dio.post(
      ApiConfig.LEAD_INBOX_API_ENDPOINT,
      data: payload,
      options: Options(
        headers: {
          'token': ApiConfig.AUTH_TOKEN,
          'deviceId': ApiConfig.DEVICE_ID,
          'userid': '4321',
        },
      ),
    );
  }
}
