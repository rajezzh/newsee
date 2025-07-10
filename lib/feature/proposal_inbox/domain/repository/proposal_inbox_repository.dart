import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/feature/leadInbox/domain/modal/lead_request.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/proposal_inbox_responce_model.dart';

abstract class ProposalInboxRepository {
  Future<AsyncResponseHandler<Failure, List<ProposalInboxResponseModel>>>
  searchProposalInbox(LeadInboxRequest req);
}
