import 'package:bloc/bloc.dart';
part 'progressbar_event.dart';
part 'progressbar_state.dart';

final class ProgressBarBloc extends Bloc<ProgressbarEvent, ProgressbarState> {
  // final double progressvalue;
  ProgressBarBloc(): super(ProgressInit()) {
    on<ProgressFetchEvent>(fetchingstatus);
  }
   
  void fetchingstatus(ProgressFetchEvent event, Emitter emit) async{
    await Future.delayed(
      Duration(milliseconds: 3000)
    );
    emit(ProgressValueSet(event.progressValue));
  }



}