import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_response.dart';
import 'package:newsee/feature/aadharvalidation/domain/repository/aadharvalidate_repo.dart';
import 'package:newsee/feature/aadharvalidation/presentation/bloc/aadhar_event.dart';
import 'package:newsee/feature/aadharvalidation/presentation/bloc/aadhar_state.dart';

class AadharBloc extends Bloc<AadharEvent, AadharState> {
  final AadharvalidateRepo aadharRepo;
  AadharBloc({required this.aadharRepo, required AadharState initState})
    : super(initState) {
    on<ValiateAadharEvent>(onValidateAadhar);
  }

  Future<void> onValidateAadhar(ValiateAadharEvent event, Emitter emit) async {
    emit(state.copyWith(status: AadharValidateStatus.loading));
    AsyncResponseHandler<Failure, AadharvalidateResponse> responseHandler =
        await aadharRepo.validateAadhar(request: event.request);
    if (responseHandler.isRight()) {
      emit(
        state.copyWith(
          status: AadharValidateStatus.success,
          aadharvalidateResponse: () => responseHandler.right,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: AadharValidateStatus.failue,
          errorMsg: () => responseHandler.left.message,
        ),
      );
    }
  }
}
