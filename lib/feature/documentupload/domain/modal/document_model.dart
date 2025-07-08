enum UploadStatus { initial, uploading, success, failed }

class DocumentImage {
  final String name;
  final double size;
  final String path;
  final UploadStatus imgStatus;
  DocumentImage({
    required this.name,
    required this.size,
    required this.path,
    this.imgStatus = UploadStatus.initial,
  });

  DocumentImage copyWith({UploadStatus? imgStatus}) {
    return DocumentImage(
      name: name,
      size: size,
      path: path,
      imgStatus: imgStatus ?? this.imgStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'size': size,
      'path': path,
      'imgStatus': imgStatus.name,
    };
  }

  factory DocumentImage.fromMap(Map<String, dynamic> map) {
    return DocumentImage(
      name: map['name'],
      size: (map['size'] as num).toDouble(),
      path: map['path'],
      imgStatus: UploadStatus.values.firstWhere(
        (e) => e.name == map['imgStatus'],
        orElse: () => UploadStatus.initial,
      ),
    );
  }
}

class DocumentModel {
  final String lpdDocId;
  final String lpdDocDesc;
  final String lpdManCheck;
  final String lpdRowId;
  final String lpdPartyId;
  final String lpdPartyType;
  final String lpdDocAction;
  final String lpdDocType;
  final List<DocumentImage> imgs;

  const DocumentModel({
    required this.lpdDocId,
    required this.lpdDocDesc,
    required this.lpdManCheck,
    required this.lpdRowId,
    required this.lpdPartyId,
    required this.lpdPartyType,
    required this.lpdDocAction,
    required this.lpdDocType,
    required this.imgs,
  });

  // DocumentModel copyWith(
  //   String? lpdDocId,
  //   String? lpdDocDesc,
  //   String? lpdManCheck,
  //   String? lpdRowId,
  //   String? lpdPartyId,
  //   String? lpdPartyType,
  //   String? lpdDocAction,
  //   String? lpdDocType,
  //   final List<DocumentImage>? imgs,
  // ) {
  //   return DocumentModel(
  //     lpdDocId: lpdDocId ?? this.lpdDocId,
  //     lpdDocDesc: lpdDocDesc ?? this.lpdDocDesc,
  //     lpdManCheck: lpdManCheck ?? this.lpdManCheck,
  //     lpdRowId: lpdRowId ?? this.lpdRowId,
  //     lpdPartyId: lpdPartyId ?? this.lpdPartyId,
  //     lpdPartyType: lpdPartyType ?? this.lpdPartyType,
  //     lpdDocAction: lpdDocAction ?? this.lpdDocAction,
  //     lpdDocType: lpdDocType ?? this.lpdDocType,
  //     imgs: imgs ?? this.imgs,
  //   );
  // }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      lpdDocId: map['lpdDocId']!.toString(),
      lpdDocDesc: map['lpdDocDesc']!.toString(),
      lpdManCheck: map['lpdManCheck']!.toString(),
      lpdRowId: map['lpdRowId'].toString(),
      lpdPartyId: map['lpdPartyId']!.toString(),
      lpdPartyType: map['lpdPartyType']!.toString(),
      lpdDocAction: map['lpdDocAction']!.toString(),
      lpdDocType: map['lpdDocType']!.toString(),
      imgs: [],
    );
  }

  //  Serialize to Map (e.g., for DB or sending back)
  Map<String, dynamic> toMap() {
    return {
      'lpdDocId': lpdDocId,
      'lpdDocDesc': lpdDocDesc,
      'lpdManCheck': lpdManCheck,
      'lpdRowId': lpdRowId,
      'lpdPartyId': lpdPartyId,
      'lpdPartyType': lpdPartyType,
      'lpdDocAction': lpdDocAction,
      'lpdDocType': lpdDocType,
      // 'imgs': imgs.map((e) => e.toMap()).toList(), // Only if needed
    };
  }

  // make a copy of this object with updated fields
  DocumentModel copyWith({
    String? lpdDocId,
    String? lpdDocDesc,
    String? lpdManCheck,
    String? lpdRowId,
    String? lpdPartyId,
    String? lpdPartyType,
    String? lpdDocAction,
    String? lpdDocType,
    List<DocumentImage>? imgs,
  }) {
    return DocumentModel(
      lpdDocId: lpdDocId ?? this.lpdDocId,
      lpdDocDesc: lpdDocDesc ?? this.lpdDocDesc,
      lpdManCheck: lpdManCheck ?? this.lpdManCheck,
      lpdRowId: lpdRowId ?? this.lpdRowId,
      lpdPartyId: lpdPartyId ?? this.lpdPartyId,
      lpdPartyType: lpdPartyType ?? this.lpdPartyType,
      lpdDocAction: lpdDocAction ?? this.lpdDocAction,
      lpdDocType: lpdDocType ?? this.lpdDocType,
      imgs: imgs ?? this.imgs,
    );
  }
}
