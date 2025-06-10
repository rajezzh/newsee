/* 
@author   : karthick.d  10/06/2025
@desc     : state for PersonalDetails and lov masters
 */
part of 'personal_details_bloc.dart';

/* 

 */
class PersonalDetailsState extends Equatable {
  final List<Lov>? lovList;

  PersonalDetailsState({required this.lovList});

  factory PersonalDetailsState.init() => PersonalDetailsState(lovList: []);

  @override
  List<Object?> get props => [lovList];
}
