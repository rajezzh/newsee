import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/repository/lov_crud_repo.dart';
import 'package:sqflite/sqflite.dart';

part 'cropyieldpage_event.dart';
part 'cropyieldpage_state.dart';

class CropyieldpageBloc extends Bloc<CropyieldpageEvent, CropyieldpageState> {
  CropyieldpageBloc(): super(CropyieldpageState.init()) {
    on<CropPageInitialEvent>(initCropYieldDetails);
    on<CropFormSaveEvent>(onSaveCropYieldPage);
  }

  Future<void> initCropYieldDetails(CropPageInitialEvent event, Emitter emit) async {
    try {
      Database _db = await DBConfig().database;
      List<Lov> listOfLov = await LovCrudRepo(_db).getAll();
      print('listOfLov => $listOfLov');
      emit(
        state.copyWith(
          lovList: listOfLov,
          status: CropPageStatus.init
        )
      );
    } catch(error) {
      print("onSaveCropYieldPage-error $error");
    }
  }

  onSaveCropYieldPage(CropFormSaveEvent event, Emitter emit) {
    try {
      emit(
        state.copyWith(
          status: CropPageStatus.success,
          cropdetails: event.request
        )
      );
    } catch(error) {
      print("onSaveCropYieldPage-error $error");
    }
  }
}