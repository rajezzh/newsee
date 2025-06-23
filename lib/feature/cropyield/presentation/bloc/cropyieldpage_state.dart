part of './cropyieldpage_bloc.dart';

enum CropPageStatus {init, loading, success, failure}

class CropyieldpageState extends Equatable {
  final CropPageStatus? status;
  final List<Lov>? lovList;
  final Map<String, dynamic>? cropdetails;
  final String? errorMessage;
  const CropyieldpageState({
    this.status,
    this.lovList,
    this.cropdetails,
    this.errorMessage,
  });

   factory CropyieldpageState.init() => CropyieldpageState(
    status: CropPageStatus.init,
    lovList: [],
    cropdetails: null,
    errorMessage: null
  );

  CropyieldpageState copyWith({
    CropPageStatus? status,
    List<Lov>? lovList,
    Map<String, dynamic>? cropdetails,
    String? errorMessage,
  }) {
    return CropyieldpageState(
      status: status ?? this.status,
      lovList: lovList ?? this.lovList,
      cropdetails: cropdetails ?? this.cropdetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'lovList': lovList,
      'cropdetails': cropdetails,
      'errorMessage': errorMessage,
    };
  }

  @override
  List<Object?> get props => [status, lovList, cropdetails, errorMessage];
}
