part of './progressbar_bloc.dart';

class ProgressbarEvent {
  
}


class ProgressFetchEvent extends ProgressbarEvent{
  final double progressValue;
  ProgressFetchEvent({required this.progressValue});
}