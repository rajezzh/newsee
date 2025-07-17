// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'proposal_inbox_bloc.dart';

enum ProposalInboxStatus { init, loading, success, failure }
// we need following state status which is defines http init , loading
// success and failure

class ProposalInboxState extends Equatable {
  final ProposalInboxStatus status;
  final List<GroupProposalInbox>? proposalResponseModel;
  final String? errorMessage;
  final int currentPage;
  final int? totalProposalApplication;

  const ProposalInboxState({
    this.status = ProposalInboxStatus.init,
    this.proposalResponseModel,
    this.errorMessage,
    this.currentPage = 1,
    this.totalProposalApplication,
  });

  factory ProposalInboxState.init() => const ProposalInboxState();

  ProposalInboxState copyWith({
    ProposalInboxStatus? status,
    List<GroupProposalInbox>? proposalResponseModel,
    String? errorMessage,
    int? currentPage,
    int? totalProposalApplication,
  }) {
    return ProposalInboxState(
      status: status ?? this.status,
      proposalResponseModel: proposalResponseModel ?? this.proposalResponseModel,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalProposalApplication: totalProposalApplication ?? this.totalProposalApplication,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      proposalResponseModel,
      errorMessage,
      currentPage,
      totalProposalApplication,
    ];
  }
}
