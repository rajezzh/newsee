// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProposalCreationRequest {
  final String? leadId;
  final String? userid;
  final String? token;
  final String? vertical;
  ProposalCreationRequest({
    this.leadId,
    this.userid,
    this.token,
    this.vertical,
  });

  ProposalCreationRequest copyWith({
    String? leadId,
    String? userid,
    String? token,
    String? vertical,
  }) {
    return ProposalCreationRequest(
      leadId: leadId ?? this.leadId,
      userid: userid ?? this.userid,
      token: token ?? this.token,
      vertical: vertical ?? this.vertical,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'leadId': leadId,
      'userid': userid,
      'token': token,
      'vertical': vertical,
    };
  }

  factory ProposalCreationRequest.fromMap(Map<String, dynamic> map) {
    return ProposalCreationRequest(
      leadId: map['leadId'] != null ? map['leadId'] as String : null,
      userid: map['userid'] != null ? map['userid'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      vertical: map['vertical'] != null ? map['vertical'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProposalCreationRequest.fromJson(String source) =>
      ProposalCreationRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'ProposalCreationRequest(leadId: $leadId, userid: $userid, token: $token, vertical: $vertical)';
  }

  @override
  bool operator ==(covariant ProposalCreationRequest other) {
    if (identical(this, other)) return true;

    return other.leadId == leadId &&
        other.userid == userid &&
        other.token == token &&
        other.vertical == vertical;
  }

  @override
  int get hashCode {
    return leadId.hashCode ^
        userid.hashCode ^
        token.hashCode ^
        vertical.hashCode;
  }
}
