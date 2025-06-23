import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cropyieldpage_event.dart';
part 'cropyieldpage_state.dart';

class CropyieldpageBloc extends Bloc<CropyieldpageEvent, CropyieldpageState> {
  CropyieldpageBloc(): super(CropyieldpageState()) {
    on<CropFormSaveEvent>(onSaveCropYieldPage);
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