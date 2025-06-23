// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CropDetailsModal {
  final String? season;
  final String? cropname;
  final String? acrescultivated;
  final String? typeofland;
  final String? scaleoffincance;
  final String? reqasperscaleoffinace;
  final String? notifiedcrop;
  final String? premiumperacre;
  final String? premiumcollected;
  CropDetailsModal({
    this.season,
    this.cropname,
    this.acrescultivated,
    this.typeofland,
    this.scaleoffincance,
    this.reqasperscaleoffinace,
    this.notifiedcrop,
    this.premiumperacre,
    this.premiumcollected,
  });

  CropDetailsModal copyWith({
    String? season,
    String? cropname,
    String? acrescultivated,
    String? typeofland,
    String? scaleoffincance,
    String? reqasperscaleoffinace,
    String? notifiedcrop,
    String? premiumperacre,
    String? premiumcollected,
  }) {
    return CropDetailsModal(
      season: season ?? this.season,
      cropname: cropname ?? this.cropname,
      acrescultivated: acrescultivated ?? this.acrescultivated,
      typeofland: typeofland ?? this.typeofland,
      scaleoffincance: scaleoffincance ?? this.scaleoffincance,
      reqasperscaleoffinace: reqasperscaleoffinace ?? this.reqasperscaleoffinace,
      notifiedcrop: notifiedcrop ?? this.notifiedcrop,
      premiumperacre: premiumperacre ?? this.premiumperacre,
      premiumcollected: premiumcollected ?? this.premiumcollected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'season': season,
      'cropname': cropname,
      'acrescultivated': acrescultivated,
      'typeofland': typeofland,
      'scaleoffincance': scaleoffincance,
      'reqasperscaleoffinace': reqasperscaleoffinace,
      'notifiedcrop': notifiedcrop,
      'premiumperacre': premiumperacre,
      'premiumcollected': premiumcollected,
    };
  }

  factory CropDetailsModal.fromMap(Map<String, dynamic> map) {
    return CropDetailsModal(
      season: map['season'] != null ? map['season'] as String : null,
      cropname: map['cropname'] != null ? map['cropname'] as String : null,
      acrescultivated: map['acrescultivated'] != null ? map['acrescultivated'] as String : null,
      typeofland: map['typeofland'] != null ? map['typeofland'] as String : null,
      scaleoffincance: map['scaleoffincance'] != null ? map['scaleoffincance'] as String : null,
      reqasperscaleoffinace: map['reqasperscaleoffinace'] != null ? map['reqasperscaleoffinace'] as String : null,
      notifiedcrop: map['notifiedcrop'] != null ? map['notifiedcrop'] as String : null,
      premiumperacre: map['premiumperacre'] != null ? map['premiumperacre'] as String : null,
      premiumcollected: map['premiumcollected'] != null ? map['premiumcollected'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CropDetailsModal.fromJson(String source) => CropDetailsModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CropDetailsModal(season: $season, cropname: $cropname, acrescultivated: $acrescultivated, typeofland: $typeofland, scaleoffincance: $scaleoffincance, reqasperscaleoffinace: $reqasperscaleoffinace, notifiedcrop: $notifiedcrop, premiumperacre: $premiumperacre, premiumcollected: $premiumcollected)';
  }

  @override
  bool operator ==(covariant CropDetailsModal other) {
    if (identical(this, other)) return true;
  
    return 
      other.season == season &&
      other.cropname == cropname &&
      other.acrescultivated == acrescultivated &&
      other.typeofland == typeofland &&
      other.scaleoffincance == scaleoffincance &&
      other.reqasperscaleoffinace == reqasperscaleoffinace &&
      other.notifiedcrop == notifiedcrop &&
      other.premiumperacre == premiumperacre &&
      other.premiumcollected == premiumcollected;
  }

  @override
  int get hashCode {
    return season.hashCode ^
      cropname.hashCode ^
      acrescultivated.hashCode ^
      typeofland.hashCode ^
      scaleoffincance.hashCode ^
      reqasperscaleoffinace.hashCode ^
      notifiedcrop.hashCode ^
      premiumperacre.hashCode ^
      premiumcollected.hashCode;
  }
}
