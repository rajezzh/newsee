import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/Model/address_data.dart';
import 'package:newsee/Model/personal_data.dart';
import 'package:newsee/feature/leadsubmit/domain/modal/dedupe.dart';
import 'package:newsee/feature/leadsubmit/domain/modal/lead_submit_request.dart';
import 'package:newsee/feature/leadsubmit/domain/modal/loan_product.dart';
import 'package:newsee/feature/leadsubmit/domain/modal/loan_type.dart';

part './lead_submit_event.dart';
part './lead_submit_state.dart';

/* 
@author   : karthick.d  13/06/2025
@desc     : submiting lead business logic
 */
final class LeadSubmitBloc extends Bloc<LeadSubmitEvent, LeadSubmitState> {
  LeadSubmitBloc() : super(LeadSubmitState.init()) {
    on<LeadSubmitPageInitEvent>(onLeadSubmitPageInit);
  }

  Future<void> onLeadSubmitPageInit(
    LeadSubmitPageInitEvent event,
    Emitter emit,
  ) async {
    PersonalData? personalData = event.personalData;
    LeadSubmitRequest leadSubmitRequest = LeadSubmitRequest(
      userid: '',
      orgScode: '',
      orgName: '',
      orgLevel: '',
      token: '',
      leadDetails: LoanType(),
      chooseProduct: LoanProduct(
        mainCategory: '',
        subCategory: '',
        producrId: '',
      ),
      dedupeSearch: Dedupe(
        existingCustomer: false,
        cifNumber: '',
        constitution: '',
      ),
      individualNonIndividualDetails: personalData ?? null,
      addressDetails: AddressData(),
    );
    emit(state.copyWith(leadSubmitRequest: leadSubmitRequest));
  }
}
