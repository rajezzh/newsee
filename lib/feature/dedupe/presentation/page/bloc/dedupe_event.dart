part of 'dedupe_bloc.dart';

class DedupeEvent {

}

class FetchDedupeEvent extends DedupeEvent {
  DedupeRequest request;
  FetchDedupeEvent({required this.request});
}