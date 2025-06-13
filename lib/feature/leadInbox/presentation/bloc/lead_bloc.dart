import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsee/feature/leadInbox/data/repository/lead_respository_impl.dart';
import 'package:newsee/feature/leadInbox/domain/modal/lead_request.dart';
import 'package:newsee/feature/leadInbox/domain/modal/lead_responce_model.dart';
import 'package:newsee/feature/leadInbox/domain/repository/lead_repository.dart';

part 'lead_event.dart';
part 'lead_state.dart';

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  final LeadRepository leadRepository;

  LeadBloc({LeadRepository? repository})
      : leadRepository = repository ?? LeadRepositoryImpl(),
        super(LeadState()) {
    on<SearchLeadEvent>(onSearchLead);
  }

  Future<void> onSearchLead(SearchLeadEvent event, Emitter<LeadState> emit) async {
    emit(state.copyWith(status: LeadStatus.loading));

    final response = await leadRepository.searchLead(event.request);

    if (response.isRight()) {
      emit(state.copyWith(
        status: LeadStatus.success,
        leadResponseModel: response.right,
      ));
    } else {
      print('Lead failure response.left');
      emit(state.copyWith(
        status: LeadStatus.failure,
        errorMessage: response.left.message,
      ));
    }
  }
}
