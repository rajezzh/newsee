import 'dart:convert';

/*
  @author     : gayathri.b 12/06/2025
 @description: Represents the request payload for the lead search API.
   */
class LeadRequest {
  String userid;
  String? token;
  int? page;

  LeadRequest({required this.userid, this.token,this.page});

  LeadRequest copyWith({String? userid, String? token, int ? page}) {
    return LeadRequest(
      userid: userid ?? this.userid,
      token: token ?? this.token,
      page: page?? this.page
    );
  }

  Map<String, dynamic> toMap() {
    return {'userid': userid, 'token': token, 'page':page};
  }

  factory LeadRequest.fromMap(Map<String, dynamic> map) {
    return LeadRequest(
      userid: map['userid'] as String,
      token: map['token'] as String?,
      page:map['page']as int?
    );
  }

  String toJson() => json.encode(toMap());

  factory LeadRequest.fromJson(String source) =>
      LeadRequest.fromMap(json.decode(source));
}
