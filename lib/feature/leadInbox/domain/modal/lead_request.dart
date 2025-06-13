import 'dart:convert';

class LeadRequest {
  String userid;
  String? token;

  LeadRequest({ 
    required this.userid,
    this.token,
  });

  LeadRequest copyWith({
    String? userid,
    String? token,
  }) {
    return LeadRequest(
      userid: userid ?? this.userid,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'token': token,
    };
  }

  factory LeadRequest.fromMap(Map<String, dynamic> map) {
    return LeadRequest(
      userid: map['userid'] as String,
      token: map['token'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeadRequest.fromJson(String source) =>
      LeadRequest.fromMap(json.decode(source));
}
