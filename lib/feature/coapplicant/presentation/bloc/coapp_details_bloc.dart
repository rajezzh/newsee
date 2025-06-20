/* 
@autor      : karthick.d  20/06/2025
@desc       : bloc for saving co appdetails 
              more than one co-app can be add to co app list 
              co-applicant is optional and will be sent as part of lead details

 */

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/AppData/DBConstants/table_key_geographymaster.dart';
import 'package:newsee/AppData/app_constants.dart';
import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/addressdetails/data/repository/citylist_repo_impl.dart';
import 'package:newsee/feature/addressdetails/domain/model/citydistrictrequest.dart';
import 'package:newsee/feature/addressdetails/domain/repository/cityrepository.dart';
import 'package:newsee/feature/coapplicant/domain/modal/coapplicant_data.dart';
import 'package:newsee/feature/masters/domain/modal/geography_master.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/repository/geographymaster_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/lov_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

part 'coapp_details_event.dart';
part 'coapp_details_state.dart';

final class CoappDetailsBloc
    extends Bloc<CoappDetailsEvent, CoappDetailsState> {
  CoappDetailsBloc() : super(CoappDetailsState.initial()) {
    on<CoAppDetailsInitEvent>(initCoAppDetailsPage);
    on<CoAppDetailsSaveEvent>(saveCoAppDetailsPage);
    on<OnStateCityChangeEvent>(getCityListBasedOnState);
  }

  Future<void> initCoAppDetailsPage(
    CoAppDetailsInitEvent event,
    Emitter emit,
  ) async {
    // fetch lov
    Database _db = await DBConfig().database;
    List<Lov> listOfLov = await LovCrudRepo(_db).getAll();
    List<GeographyMaster> stateCityMaster = await GeographymasterCrudRepo(
      _db,
    ).getByColumnNames(
      columnNames: [
        TableKeysGeographyMaster.stateId,
        TableKeysGeographyMaster.cityId,
      ],
      columnValues: ['0', '0'],
    );

    print('listOfLov => $listOfLov');

    emit(state.copyWith(lovList: listOfLov, stateCityMaster: stateCityMaster));
  }

  Future<void> saveCoAppDetailsPage(
    CoAppDetailsSaveEvent event,
    Emitter emit,
  ) async {
    print('PersonalData => ${event.coapplicantData}');

    emit(
      state.copyWith(
        selectedCoApp: event.coapplicantData,
        status: SaveStatus.success,
      ),
    );
  }

  Future<void> getCityListBasedOnState(
    OnStateCityChangeEvent event,
    Emitter emit,
  ) async {
    Database db = await DBConfig().database;
    List<String> columnNames = [
      TableKeysGeographyMaster.stateId,
      TableKeysGeographyMaster.cityId,
    ];
    List<String> columnValues;
    if (event.cityCode != null) {
      columnValues = [event.stateCode, event.cityCode ?? '0'];
    } else {
      columnValues = [event.stateCode, '0'];
    }

    emit(state.copyWith(status: SaveStatus.loading));
    List<GeographyMaster> cityDistrictMaster = await GeographymasterCrudRepo(
      db,
    ).getByColumnNames(columnNames: columnNames, columnValues: columnValues);
    if (event.cityCode == null && cityDistrictMaster.isNotEmpty) {
      await Future.delayed(Duration(seconds: 3));
      emit(
        state.copyWith(
          cityMaster: cityDistrictMaster,
          status: SaveStatus.mastersucess,
        ),
      );
    } else if (event.cityCode != null && cityDistrictMaster.isNotEmpty) {
      await Future.delayed(Duration(seconds: 3));
      emit(
        state.copyWith(
          districtMaster: cityDistrictMaster,
          status: SaveStatus.mastersucess,
        ),
      );
    } else {
      emit(state.copyWith(status: SaveStatus.loading));
      final CityDistrictRequest citydistrictrequest;
      Cityrepository cityrepository = CitylistRepoImpl();
      AsyncResponseHandler<Failure, dynamic> responseHandler;
      if (event.cityCode != null) {
        citydistrictrequest = CityDistrictRequest(
          stateCode: event.stateCode,
          cityCode: event.cityCode,
        );
        responseHandler = await cityrepository.fetchCityList(
          citydistrictrequest,
        );
      } else {
        citydistrictrequest = CityDistrictRequest(stateCode: event.stateCode);
        responseHandler = await cityrepository.fetchCityList(
          citydistrictrequest,
        );
      }
      if (responseHandler.isRight()) {
        List<GeographyMaster> cityList = responseHandler.right;
        if (cityList.isNotEmpty) {
          Iterator<GeographyMaster> it = cityList.iterator;
          GeographymasterCrudRepo statecityMasterCrudRepo =
              GeographymasterCrudRepo(db);
          while (it.moveNext()) {
            statecityMasterCrudRepo.save(it.current);
          }
          if (event.cityCode != null) {
            await Future.delayed(Duration(seconds: 3));
            emit(
              state.copyWith(
                districtMaster: cityList,
                status: SaveStatus.mastersucess,
              ),
            );
          } else {
            await Future.delayed(Duration(seconds: 3));
            emit(
              state.copyWith(
                cityMaster: cityList,
                status: SaveStatus.mastersucess,
              ),
            );
          }
        } else {
          if (event.cityCode != null) {
            await Future.delayed(Duration(seconds: 3));
            emit(
              state.copyWith(
                districtMaster: <GeographyMaster>[],
                status: SaveStatus.failure,
              ),
            );
          } else {
            await Future.delayed(Duration(seconds: 3));
            emit(
              state.copyWith(
                cityMaster: <GeographyMaster>[],
                status: SaveStatus.mastersucess,
              ),
            );
          }
        }
      } else {
        emit(state.copyWith(status: SaveStatus.failure));
      }
    }
  }
}
