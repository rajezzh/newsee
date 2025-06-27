// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CropModal {
  String? taluk;
  String? agriCultivated;
  String? state;
  String? firka;
  String? distanceFromBranch;
  int? irrigated;
  String? natureOfRight;
  String? district;
  String? village;
  int? rainfed;
  int? total;
  String? cropsCultivatedOrProposedCrops;
  String? surveyNo;
  String? farmDistance;
  CropModal({
    this.taluk,
    this.agriCultivated,
    this.state,
    this.firka,
    this.distanceFromBranch,
    this.irrigated,
    this.natureOfRight,
    this.district,
    this.village,
    this.rainfed,
    this.total,
    this.cropsCultivatedOrProposedCrops,
    this.surveyNo,
    this.farmDistance,
  });

  CropModal copyWith({
    String? taluk,
    String? agriCultivated,
    String? state,
    String? firka,
    String? distanceFromBranch,
    int? irrigated,
    String? natureOfRight,
    String? district,
    String? village,
    int? rainfed,
    int? total,
    String? cropsCultivatedOrProposedCrops,
    String? surveyNo,
    String? farmDistance,
  }) {
    return CropModal(
      taluk: taluk ?? this.taluk,
      agriCultivated: agriCultivated ?? this.agriCultivated,
      state: state ?? this.state,
      firka: firka ?? this.firka,
      distanceFromBranch: distanceFromBranch ?? this.distanceFromBranch,
      irrigated: irrigated ?? this.irrigated,
      natureOfRight: natureOfRight ?? this.natureOfRight,
      district: district ?? this.district,
      village: village ?? this.village,
      rainfed: rainfed ?? this.rainfed,
      total: total ?? this.total,
      cropsCultivatedOrProposedCrops: cropsCultivatedOrProposedCrops ?? this.cropsCultivatedOrProposedCrops,
      surveyNo: surveyNo ?? this.surveyNo,
      farmDistance: farmDistance ?? this.farmDistance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taluk': taluk,
      'agriCultivated': agriCultivated,
      'state': state,
      'firka': firka,
      'distanceFromBranch': distanceFromBranch,
      'irrigated': irrigated,
      'natureOfRight': natureOfRight,
      'district': district,
      'village': village,
      'rainfed': rainfed,
      'total': total,
      'cropsCultivatedOrProposedCrops': cropsCultivatedOrProposedCrops,
      'surveyNo': surveyNo,
      'farmDistance': farmDistance,
    };
  }

  factory CropModal.fromMap(Map<String, dynamic> map) {
    return CropModal(
      taluk: map['taluk'] != null ? map['taluk'] as String : null,
      agriCultivated: map['agriCultivated'] != null ? map['agriCultivated'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      firka: map['firka'] != null ? map['firka'] as String : null,
      distanceFromBranch: map['distanceFromBranch'] != null ? map['distanceFromBranch'] as String : null,
      irrigated: map['irrigated'] != null ? map['irrigated'] as int : null,
      natureOfRight: map['natureOfRight'] != null ? map['natureOfRight'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      village: map['village'] != null ? map['village'] as String : null,
      rainfed: map['rainfed'] != null ? map['rainfed'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
      cropsCultivatedOrProposedCrops: map['cropsCultivatedOrProposedCrops'] != null ? map['cropsCultivatedOrProposedCrops'] as String : null,
      surveyNo: map['surveyNo'] != null ? map['surveyNo'] as String : null,
      farmDistance: map['farmDistance'] != null ? map['farmDistance'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CropModal.fromJson(String source) => CropModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CropModal(taluk: $taluk, agriCultivated: $agriCultivated, state: $state, firka: $firka, distanceFromBranch: $distanceFromBranch, irrigated: $irrigated, natureOfRight: $natureOfRight, district: $district, village: $village, rainfed: $rainfed, total: $total, cropsCultivatedOrProposedCrops: $cropsCultivatedOrProposedCrops, surveyNo: $surveyNo, farmDistance: $farmDistance)';
  }

  @override
  bool operator ==(covariant CropModal other) {
    if (identical(this, other)) return true;
  
    return 
      other.taluk == taluk &&
      other.agriCultivated == agriCultivated &&
      other.state == state &&
      other.firka == firka &&
      other.distanceFromBranch == distanceFromBranch &&
      other.irrigated == irrigated &&
      other.natureOfRight == natureOfRight &&
      other.district == district &&
      other.village == village &&
      other.rainfed == rainfed &&
      other.total == total &&
      other.cropsCultivatedOrProposedCrops == cropsCultivatedOrProposedCrops &&
      other.surveyNo == surveyNo &&
      other.farmDistance == farmDistance;
  }

  @override
  int get hashCode {
    return taluk.hashCode ^
      agriCultivated.hashCode ^
      state.hashCode ^
      firka.hashCode ^
      distanceFromBranch.hashCode ^
      irrigated.hashCode ^
      natureOfRight.hashCode ^
      district.hashCode ^
      village.hashCode ^
      rainfed.hashCode ^
      total.hashCode ^
      cropsCultivatedOrProposedCrops.hashCode ^
      surveyNo.hashCode ^
      farmDistance.hashCode;
  }
}
