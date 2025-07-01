part of 'proposal_inbox_bloc.dart';

abstract class ProposalInboxEvent {
  const ProposalInboxEvent();
}
// bloc event type that will be called when Login button clicked

class SearchProposalInboxEvent extends ProposalInboxEvent {
  final ProposalInboxRequest request;

  const SearchProposalInboxEvent({required this.request});

  @override
  List<Object?> get props => [request];
}
