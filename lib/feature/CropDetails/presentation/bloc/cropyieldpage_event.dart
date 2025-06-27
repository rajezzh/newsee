part of './cropyieldpage_bloc.dart';

class CropyieldpageEvent {

}

class CropPageInitialEvent extends CropyieldpageEvent {
  final String proposalNumber;
  CropPageInitialEvent({required this.proposalNumber});
}

class CropFormSaveEvent extends CropyieldpageEvent {
  final CropDetailsModal cropData;
  CropFormSaveEvent({required this.cropData});
}

class CropDetailsSetEvent extends CropyieldpageEvent {
  final CropDetailsModal cropData;
  CropDetailsSetEvent({required this.cropData});
}

class CropDetailsResetEvent extends CropyieldpageEvent{}

class CropDetailsUpdateEvent extends CropyieldpageEvent{
  final CropDetailsModal cropData;
  final int index;
  CropDetailsUpdateEvent({required this.cropData, required this.index});
}

class CropDetailsSubmitEvent extends CropyieldpageEvent{
  final String proposalNumber;
  final String userid;
  final int irrigated;
  final int rainfed;
  final int total;
  CropDetailsSubmitEvent({
    required this.proposalNumber, 
    required this.userid, 
    required this.irrigated,
    required this.rainfed,
    required this.total
  });
}
