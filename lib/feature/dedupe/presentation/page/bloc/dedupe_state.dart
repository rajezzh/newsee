// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dedupe_bloc.dart';

enum DedupeFetchStatus { init, loading, success, failue }

class DedupeState extends Equatable {
  final DedupeFetchStatus status;
  final String? errorMsg;
  final DedupeResponse? dedupeResponse;

  DedupeState({
    required this.status,
    this.errorMsg,
    this.dedupeResponse,
  });

  DedupeState copyWith({
    DedupeFetchStatus? status,
    String? errorMsg,
    DedupeResponse? dedupeResponse,
  }) {
    return DedupeState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      dedupeResponse: dedupeResponse ?? this.dedupeResponse,
    );
  }
  
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, errorMsg, dedupeResponse];
}
