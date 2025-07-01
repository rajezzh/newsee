part of 'proposal_inbox_bloc.dart';

enum ProposalInboxStatus { init, loading, success, failure }
// we need following state status which is defines http init , loading
// success and failure

class ProposalInboxState extends Equatable {
  final ProposalInboxStatus status;
  final List<ProposalInboxResponseModel>? proposalResponseModel;
  final String? errorMessage;

  const ProposalInboxState({
    this.status = ProposalInboxStatus.init,
    this.proposalResponseModel,
    this.errorMessage,
  });

  factory ProposalInboxState.init() => const ProposalInboxState();

  ProposalInboxState copyWith({
    ProposalInboxStatus? status,
    List<ProposalInboxResponseModel>? proposalResponseModel,
    String? errorMessage,
  }) {
    return ProposalInboxState(
      status: status ?? this.status,
      proposalResponseModel:
          proposalResponseModel ?? this.proposalResponseModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, proposalResponseModel, errorMessage];
}
