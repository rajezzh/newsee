// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ProposalInboxResponseModel {
  final List<Map<String, dynamic>> proposalDetails;

  ProposalInboxResponseModel({required this.proposalDetails});

  ProposalInboxResponseModel copyWith({
    List<Map<String, dynamic>>? proposalDetails,
  }) {
    return ProposalInboxResponseModel(
      proposalDetails: proposalDetails ?? this.proposalDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'proposalDetails': proposalDetails};
  }

  factory ProposalInboxResponseModel.fromMap(Map<String, dynamic> map) {
    return ProposalInboxResponseModel(
      proposalDetails: List<Map<String, dynamic>>.from(
        (map['proposalDetails'] as List).map(
          (e) => Map<String, dynamic>.from(e as Map),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProposalInboxResponseModel.fromJson(String source) =>
      ProposalInboxResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'ProposalInboxResponseModel(proposalDetails: $proposalDetails)';

  @override
  bool operator ==(covariant ProposalInboxResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.proposalDetails, proposalDetails);
  }

  @override
  int get hashCode => proposalDetails.hashCode;
}
