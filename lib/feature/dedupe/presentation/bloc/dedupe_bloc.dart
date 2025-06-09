import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/feature/dedupe/domain/model/deduperequest.dart';
import 'package:newsee/feature/dedupe/domain/model/deduperesponse.dart';
import 'package:newsee/feature/dedupe/domain/repositoy/deduperepository.dart';

part 'dedupe_event.dart';
part 'dedupe_state.dart';

class DedupeBloc extends Bloc<DedupeEvent, DedupeState> {
  final DedupeRepository dedupeRepository;
  DedupeBloc({required this.dedupeRepository, required DedupeState initState}):super(initState) {
    on<FetchDedupeEvent>(dedupeFetch);
  }

  Future<void> dedupeFetch(FetchDedupeEvent event, Emitter emit) async {
    emit(state.copyWith(status: DedupeFetchStatus.loading));
    final DedupeRequest dedupeRea =  event.request;
    var responseHandler = await dedupeRepository.dedupeSearchforCustomer(dedupeRea);
    if (responseHandler.isRight()) {
      emit(state.
        copyWith(
          status: DedupeFetchStatus.success,
          dedupeResponse: responseHandler.right,
        )
      );
    } else {
      emit(state.
        copyWith(
          status: DedupeFetchStatus.failure,
          errorMsg: responseHandler.left.message,
        )
      );
    }
  }
}