part of 'lead_bloc.dart';

abstract class LeadEvent {
  const LeadEvent();
  
}
// bloc event type that will be called when Login button clicked

class SearchLeadEvent extends LeadEvent {
  final LeadRequest request;

  const SearchLeadEvent({required this.request});

  @override
  List<Object?> get props => [request];
}

class PageChangedEvent extends  LeadEvent {
 final int newPage ;
 final LeadRequest previousRequest ;

  const PageChangedEvent(this.newPage, this.previousRequest);
 
 @override
 List<Object> get props => [newPage, previousRequest];
}
