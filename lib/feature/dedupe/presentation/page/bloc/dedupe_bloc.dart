import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/feature/dedupe/data/repository/dedupe_search_repo_impl.dart';
import 'package:newsee/feature/dedupe/domain/model/deduperequest.dart';
import 'package:newsee/feature/dedupe/domain/model/deduperesponse.dart';

part './dedupe_event.dart';
part './dedupe_state.dart';

class DedupeBloc extends Bloc<DedupeEvent, DedupeState> {
  DedupeBloc({required DedupeState initState}):super(initState) {
    on<FetchDedupeEvent>(dedupeFetch);
  }

  Future<void> dedupeFetch(FetchDedupeEvent event, Emitter emit) async {
    print("Again Callinge here to know status => ${state.status}");
    emit(state.copyWith(status: DedupeFetchStatus.loading));
    final DedupeRequest dedupeRea =  event.request;
    var responseHandler = await DedupeSearchRepositoryimpl().dedupeSearchforCustomer(dedupeRea);
    print("responseHandler-dedupeFetch-string ${responseHandler.toString()}");

    if (responseHandler.isRight()) {
      emit(state.copyWith(
          status: DedupeFetchStatus.success,
          dedupeResponse: responseHandler.right
        )
      );
    } else {
      emit(state.copyWith(
          status: DedupeFetchStatus.failue,
          errorMsg: responseHandler.left.message
        )
      );
    }
  }
}