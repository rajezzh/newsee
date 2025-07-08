import 'package:dio/dio.dart';
import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/failure.dart';

abstract class GetDocumentsRepo {
  Future<AsyncResponseHandler<Failure, Map<String, dynamic>>> getDocuments({
    required Map<String, dynamic> request,
  });
}

abstract class FetchDocImageRepo {
  Future<AsyncResponseHandler<Failure, Map<String, dynamic>>>
  fetchDocumentImage({required Map<String, dynamic> request});
}

abstract class UploadDocumentsRepo {
  Future<AsyncResponseHandler<Failure, Map<String, dynamic>>> uploadDoc({
    required FormData request,
  });
}

abstract class DeleteUploadedDocRepo {
  Future<AsyncResponseHandler<Failure, Map<String, dynamic>>>
  deleteUploadedDoc({required Map<String, dynamic> request});
}
