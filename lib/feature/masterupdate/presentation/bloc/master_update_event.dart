/* 
@author    :  karthick.d 23/05/2025
@desc      :  Event Registers for Masters Download feature
@param     :  none
 */
part of 'master_update_bloc.dart';

sealed class MasterUpdateEvent {}

final class MasterVersionCheck extends MasterUpdateEvent {}
