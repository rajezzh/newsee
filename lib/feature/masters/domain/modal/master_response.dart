import 'package:newsee/feature/masters/domain/modal/master_types.dart';

class MasterResponse<T> {
  final List<T> master;
  final MasterTypes masterType;
  final bool? skipMaster;
  MasterResponse({required this.master, required this.masterType, this.skipMaster});
}
