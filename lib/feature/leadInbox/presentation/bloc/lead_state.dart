part of 'lead_bloc.dart';

/* 
  @author     : gayathri.b 12/05/2025
  @desc       : Encapsulates the state used in the lead search BLoC.
                Maintains the current status, API response data (LeadResponseModel),
                and any error message resulting from the lead search process.
  
*/
enum LeadStatus { initial, loading, success, failure }
// we need following state status which is defines http init , loading
// success and failure

class LeadState extends Equatable {
  final LeadStatus status;
  final List<GroupLeadInbox>? leadResponseModel;
  final String? errorMessage;
  final int currentPage ;
  final String? proposalNo;
  final SaveStatus? proposalSubmitStatus;

  const LeadState({
    this.status = LeadStatus.initial,
    this.leadResponseModel,
    this.errorMessage,
    this.currentPage = 1  ,
    this.proposalNo,
    this.proposalSubmitStatus,
  });

  factory LeadState.init() => const LeadState();

  LeadState copyWith({
    LeadStatus? status,
    List<GroupLeadInbox>? leadResponseModel,
    String? errorMessage,
    int? currentPage,
    String? proposalNo,
    SaveStatus? proposalSubmitStatus,

  }) {
    return LeadState(
      status: status ?? this.status,
      leadResponseModel: leadResponseModel ?? this.leadResponseModel,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage:currentPage ?? this.currentPage,
      proposalNo:proposalNo ?? this.proposalNo,
      proposalSubmitStatus:proposalSubmitStatus ?? this.proposalSubmitStatus,
    );
  }

  @override
  List<Object?> get props => [status, leadResponseModel, errorMessage,currentPage,proposalNo,proposalSubmitStatus];
}
