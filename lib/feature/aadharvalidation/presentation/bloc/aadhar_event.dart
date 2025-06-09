import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_request.dart';
import 'package:newsee/feature/aadharvalidation/domain/repository/aadharvalidate_repo.dart';

abstract class AadharEvent {}

class ValiateAadharEvent extends AadharEvent {
  final AadharvalidateRequest request;
  ValiateAadharEvent({required this.request});
}
