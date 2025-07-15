// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:newsee/feature/leadInbox/domain/modal/group_lead_inbox.dart';

/*
  @author      : gayathri.b 11/06/2025
  @description : Represents the response payload returned from the lead search API.
                 This model contains lead list data, types of loans, and sourcing channel LOVs,
                 and supports JSON serialization, deep equality, and immutability.
 @param       : leadlists - List of leads returned from the API.
                 typeofloan - List of available loan types.
                 sourcingChannelLov - List of sourcing channels (LOVs).
  @return      : JSON serializable object used across data and domain layers.
                
*/

class LeadResponseModel {
  final List<GroupLeadInbox> listOfApplication;
  final int totalApplication;

  LeadResponseModel({
    required this.listOfApplication,
    required this.totalApplication,
  });

  LeadResponseModel copyWith({
    List<GroupLeadInbox>? listOfApplication,
    int? totalApplication,
  }) {
    return LeadResponseModel(
      listOfApplication: listOfApplication ?? this.listOfApplication,
      totalApplication: totalApplication ?? this.totalApplication,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listOfApplication': listOfApplication.map((x) => x.toMap()).toList(),
      'totalApplication': totalApplication,
    };
  }

  factory LeadResponseModel.fromMap(Map<String, dynamic> map) {
    return LeadResponseModel(
      listOfApplication: List<GroupLeadInbox>.from((map['listOfApplication'] as List<int>).map<GroupLeadInbox>((x) => GroupLeadInbox.fromMap(x as Map<String,dynamic>),),),
      totalApplication: map['totalApplication'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeadResponseModel.fromJson(String source) => LeadResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LeadResponseModel(listOfApplication: $listOfApplication, totalApplication: $totalApplication)';

  @override
  int get hashCode => listOfApplication.hashCode ^ totalApplication.hashCode;
}
