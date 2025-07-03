// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:newsee/feature/CropDetails/domain/modal/cropdetailsmodal.dart';
import 'package:newsee/feature/CropDetails/domain/modal/cropmodel.dart';

class CropRequestModel {
  String? proposalNumber;
  String? userid;
  CropModal? cropDetailModel;
  List<CropDetailsModal>? assessmentSOF;
  String? token;
  CropRequestModel({
    this.proposalNumber,
    this.userid,
    this.cropDetailModel,
    this.assessmentSOF,
    this.token
  });

  CropRequestModel copyWith({
    String? proposalNumber,
    String? userid,
    CropModal? cropDetailModel,
    List<CropDetailsModal>? assessmentSOF,
    String? token,
  }) {
    return CropRequestModel(
      proposalNumber: proposalNumber ?? this.proposalNumber,
      userid: userid ?? this.userid,
      cropDetailModel: cropDetailModel ?? this.cropDetailModel,
      assessmentSOF: assessmentSOF ?? this.assessmentSOF,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'proposalNumber': proposalNumber,
      'userid': userid,
      'cropDetailModel': cropDetailModel?.toMap(),
      'assessmentSOF': assessmentSOF?.map((x) => x.toMap()).toList(),
      'token': token
    };
  }

  factory CropRequestModel.fromMap(Map<String, dynamic> map) {
    return CropRequestModel(
      proposalNumber: map['proposalNumber'] != null ? map['proposalNumber'] as String : null,
      userid: map['userid'] != null ? map['userid'] as String : null,
      cropDetailModel: map['cropDetailModel'] != null ? CropModal.fromMap(map['cropDetailModel'] as Map<String,dynamic>) : null,
      assessmentSOF: map['assessmentSOF'] != null ? List<CropDetailsModal>.from((map['assessmentSOF'] as List<int>).map<CropDetailsModal?>((x) => CropDetailsModal.fromMap(x as Map<String,dynamic>),),) : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CropRequestModel.fromJson(String source) => CropRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CropRequestModel(proposalNumber: $proposalNumber, userid: $userid, cropDetailModel: $cropDetailModel, assessmentSOF: $assessmentSOF)';
  }

  @override
  bool operator ==(covariant CropRequestModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.proposalNumber == proposalNumber &&
      other.userid == userid &&
      other.cropDetailModel == cropDetailModel &&
      other.token == token &&
      listEquals(other.assessmentSOF, assessmentSOF);
  }

  @override
  int get hashCode {
    return proposalNumber.hashCode ^
      userid.hashCode ^
      cropDetailModel.hashCode ^
      assessmentSOF.hashCode;
  }
}
