// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/*
  @author     : gayathri.b 12/06/2025
 @description: Represents the request payload for the lead search API.
   */
class LeadInboxRequest {
  String userid;
  String token;
  int pageNo;
  int pageCount;

  LeadInboxRequest({
    required this.userid,
    required this.token,
    this.pageNo = 0,
    this.pageCount = 20,
  });

  LeadInboxRequest copyWith({
    String? userid,
    String? token,
    int? pageNo,
    int? pageCount,
  }) {
    return LeadInboxRequest(
      userid: userid ?? this.userid,
      token: token ?? this.token,
      pageNo: pageNo ?? this.pageNo,
      pageCount: pageCount ?? this.pageCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'token': token,
      'pageNo': pageNo,
      'pageCount': pageCount,
    };
  }

  factory LeadInboxRequest.fromMap(Map<String, dynamic> map) {
    return LeadInboxRequest(
      userid: map['userid'] as String,
      token: map['token'] as String,
      pageNo: map['pageNo'] as int,
      pageCount: map['pageCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeadInboxRequest.fromJson(String source) =>
      LeadInboxRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LeadInboxRequest(userid: $userid, token: $token, pageNo: $pageNo, pageCount: $pageCount)';
  }

  @override
  bool operator ==(covariant LeadInboxRequest other) {
    if (identical(this, other)) return true;

    return other.userid == userid &&
        other.token == token &&
        other.pageNo == pageNo &&
        other.pageCount == pageCount;
  }

  @override
  int get hashCode {
    return userid.hashCode ^
        token.hashCode ^
        pageNo.hashCode ^
        pageCount.hashCode;
  }
}
