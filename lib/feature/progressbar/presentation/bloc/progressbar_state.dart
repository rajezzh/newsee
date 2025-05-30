part of './progressbar_bloc.dart';

class ProgressbarState {}


class ProgressInit extends ProgressbarState{ 

  
}

class ProgressValueSet extends ProgressbarState {
  final double progresSetValue;
  ProgressValueSet(this.progresSetValue);
}