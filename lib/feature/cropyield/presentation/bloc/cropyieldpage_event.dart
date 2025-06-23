part of './cropyieldpage_bloc.dart';

class CropyieldpageEvent {

}

class CropPageInitialEvent extends CropyieldpageEvent {
  
}

class CropFormSaveEvent extends CropyieldpageEvent {
  final Map<String, dynamic> request;
  CropFormSaveEvent({required this.request});
}