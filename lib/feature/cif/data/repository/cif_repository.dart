import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/core/api/auth_failure.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/feature/cif/data/datasource/cif_remote_datasource.dart';
import 'package:newsee/feature/cif/domain/model/user/cif_response_model.dart';
import 'package:newsee/feature/cif/domain/repository/cif_repository.dart';

class CifRepositoryImpl implements CifRepository {
  // final CifRemoteDatasource cifRemoteDatasource;

  // CifRepositoryImpl({required this.cifRemoteDatasource});

  @override
  Future<AsyncResponseHandler<Failure, CifResponseModel>> searchCif(
    Map<String, dynamic> req,
  ) async {
    try {
      print('CIF Search request payload => $req');
      final payload =  {
        "custId": "902534",
        "uniqueId": "3",
        "cifId": '121212',
        "type": "borrower",
        "token": "U2FsdGVkX1/Wa6+JeCIOVLl8LTr8WUocMz8kIGXVbEI9Q32v7zRLrnnvAIeJIVV3"
      };
      var response = await CifRemoteDatasource(dio: ApiClient().getDio()).searchCif(payload);

      if (response.data['Success']) {
        var cifResponse = CifResponseModel.fromJson(
          response.data['responseData'],
        );
        print('ChifResponseModel => ${cifResponse.toString()}');
        return AsyncResponseHandler.right(cifResponse);
      } else {
        var errorMessage = response.data['ErrorMessage'] ?? "Unknown error";
        print('CIF Search error => $errorMessage');
        return AsyncResponseHandler.left(AuthFailure(message: errorMessage));
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return AsyncResponseHandler.left(
          AuthFailure(
            message: "Could not reach server. Please try again later.",
          ),
        );
      }
      return AsyncResponseHandler.left(
        AuthFailure(message: "Server Error Occurred"),
      );
    } on Exception {
      return AsyncResponseHandler.left(
        AuthFailure(message: "Unexpected Failure during CIF Search"),
      );
    }
  }
}
