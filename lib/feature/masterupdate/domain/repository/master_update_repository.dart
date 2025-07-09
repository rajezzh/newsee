import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/failure.dart';

abstract class MasterUpdateRepository {
  Future<AsyncResponseHandler<Failure, Map<String, dynamic>>> getMastersVersion(); 
}
