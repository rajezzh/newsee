import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/group_proposal_inbox.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/proposal_inbox_request.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/proposal_inbox_responce_model.dart';

abstract class ProposalInboxRepository {
  Future<AsyncResponseHandler<Failure, List<ProposalInboxResponseModel>>>
  searchProposalInbox(ProposalInboxRequest req);
}
