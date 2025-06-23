import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/landholding/domain/modal/LandData.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/repository/lov_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

part 'land_holding_event.dart';
part 'land_holding_state.dart';

final class LandHoldingBloc extends Bloc<LandHoldingEvent, LandHoldingState> {
  LandHoldingBloc() : super(LandHoldingState.init()) {
    on<LandHoldingInitEvent>(initLandHoldingDetails);
    on<LandDetailsSaveEvent>(_onSubmit);
    on<LandDetailsLoadEvent>(_onLoad);
  }

  Future initLandHoldingDetails(
    LandHoldingInitEvent event,
    Emitter emit,
  ) async {
    Database _db = await DBConfig().database;
    List<Lov> listOfLov = await LovCrudRepo(_db).getAll();
    print('listOfLov => $listOfLov');
    emit(state.copyWith(lovlist: listOfLov, status: SaveState.initial));
  }

  // Save new land data
  Future<void> _onSubmit(
    LandDetailsSaveEvent event,
    Emitter<LandHoldingState> emit,
  ) async {
    final newList = [...?state.landData, event.landData];
    emit(
      state.copyWith(
        status: SaveState.success,
        landData: newList,
        selectedLandData: null,
      ),
    );
  }

  // Load data into form for editing
  void _onLoad(LandDetailsLoadEvent event, Emitter<LandHoldingState> emit) {
    emit(state.copyWith(selectedLandData: event.landData));
  }
}
