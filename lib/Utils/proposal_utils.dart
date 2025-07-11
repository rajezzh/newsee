import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppData/app_constants.dart';
import 'package:newsee/feature/leadsubmit/domain/modal/proposal_creation_request.dart';
import 'package:newsee/feature/leadsubmit/presentation/bloc/lead_submit_bloc.dart';

void createProposal(BuildContext context, LeadSubmitState state) {
    // when lead is submitted success
    if (state.proposalSubmitStatus == SaveStatus.init && state.leadId != null && state.proposalNo == null) {
      context.read<LeadSubmitBloc>().add(
        CreateProposalEvent(
          proposalCreationRequest: ProposalCreationRequest(
            leadId: state.leadId,
          ),
        ),
      );
    } else if (state.proposalNo != null) {
      final applicantData =
          state.leadSubmitRequest?.individualNonIndividualDetails;
      final applicantName =
          '${applicantData?.firstName} ${applicantData?.lastName}';

      context.pushNamed(
        'landholdings',
        extra: {
          'proposalNumber': state.proposalNo,
          'applicantName': applicantName,
        },
      );
    }
  }