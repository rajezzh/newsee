/* 
@author    :  gayathri 04/06/2025
@desc      :  Event Registers for CIF Search feature
@param     :  Pass CIF Reqest for Fetching Event
 */

part of 'cif_bloc.dart';

//create abstract class event extends Equatable

abstract class CifEvent extends Equatable {
  const CifEvent();

  @override
  List<Object?> get props => [];
}

//Trigger First Event SearchCif 

class SearchCifEvent extends CifEvent {
  final Map<String, dynamic> request;
  //  create constractor 
  const SearchCifEvent({required this.request});

  @override
  List<Object?> get props => [request];
}
