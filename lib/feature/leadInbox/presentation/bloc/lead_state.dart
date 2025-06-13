part of 'lead_bloc.dart';

enum LeadStatus { initial, loading, success, failure }

class LeadState extends Equatable {
  final LeadStatus status;
  final List<LeadResponseModel>? leadResponseModel;
  final String? errorMessage;

  const LeadState({
    this.status = LeadStatus.initial,
    this.leadResponseModel,
    this.errorMessage,
  });

  factory LeadState.init() => const LeadState();

  LeadState copyWith({
    LeadStatus? status,
    List<LeadResponseModel>? leadResponseModel,
    String? errorMessage,
  }) {
    return LeadState(
      status: status ?? this.status,
      leadResponseModel: leadResponseModel ?? this.leadResponseModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        leadResponseModel,
        errorMessage,
      ];
}
