import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mpin_event.dart';
import 'mpin_state.dart';

class MpinBloc extends Bloc<MpinEvent, MpinState> {
  MpinBloc() : super(const MpinState()) {
    on<UpdateMpin>((event, emit) {
      final updated = List<String>.from(state.mpin);
      updated[event.index] = event.value;
      emit(state.copyWith(mpin: updated));
    });

    on<UpdateConfirmMpin>((event, emit) {
      final updated = List<String>.from(state.confirmMpin);
      updated[event.index] = event.value;
      emit(state.copyWith(confirmMpin: updated));
    });

    on<SubmitMpin>((event, emit) async {
      final pin = state.mpin.join();
      final confirm = state.confirmMpin.join();

      if (pin.length != 4 || confirm.length != 4) {
        emit(state.copyWith(
          status: MpinStatus.failure,
          errorMessage: 'Please enter all 4 digits',
        ));
        return;
      }

      if (pin != confirm) {
        emit(state.copyWith(
          status: MpinStatus.failure,
          errorMessage: 'PINs do not match',
        ));
        return;
      }


      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_mpin', pin);
        emit(state.copyWith(status: MpinStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: MpinStatus.failure,
          errorMessage: 'Failed to save MPIN. Please try again.',
        ));
      }
    });
  }
}
