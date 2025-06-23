part of './cropyieldpage_bloc.dart';

enum CropPageStatus {init, loading, success, failure}

class CropyieldpageState extends Equatable {
  final CropPageStatus? status;
  final Map<String, dynamic>? cropdetails;
  final String? errorMessage;
  const CropyieldpageState({
    this.status,
    this.cropdetails,
    this.errorMessage,
  });

  CropyieldpageState copyWith({
    CropPageStatus? status,
    Map<String, dynamic>? cropdetails,
    String? errorMessage,
  }) {
    return CropyieldpageState(
      status: status ?? this.status,
      cropdetails: cropdetails ?? this.cropdetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'cropdetails': cropdetails,
      'errorMessage': errorMessage,
    };
  }

  @override
  List<Object?> get props => [status, cropdetails, errorMessage];
}
