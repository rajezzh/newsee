import 'package:equatable/equatable.dart';
import 'package:newsee/feature/documentupload/domain/modal/document_model.dart';

enum SubmitStatus { init, loading, success, failure }

class DocumentState extends Equatable {
  final String proposalNumber;
  final List<DocumentModel> documentsList;
  final SubmitStatus fetchStatus;
  final String uploadMessage;

  const DocumentState({
    required this.proposalNumber,
    required this.documentsList,
    required this.fetchStatus,
    required this.uploadMessage,
  });

  factory DocumentState.initial() => const DocumentState(
    proposalNumber: '',
    documentsList: [],
    fetchStatus: SubmitStatus.init,
    uploadMessage: '',
  );

  DocumentState copyWith({
    String? proposalNumber,
    List<DocumentModel>? documentsList,
    SubmitStatus? fetchStatus,
    String? uploadMessage,
  }) {
    return DocumentState(
      proposalNumber: proposalNumber ?? this.proposalNumber,
      documentsList: documentsList ?? this.documentsList,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      uploadMessage: uploadMessage ?? this.uploadMessage,
    );
  }

  /// Update just the image list of a single document
  DocumentState updateImageStatus(
    int docIndex,
    List<DocumentImage> updatedImages,
  ) {
    final updatedDocs = [...documentsList];
    final doc = updatedDocs[docIndex];
    updatedDocs[docIndex] = doc.copyWith(imgs: updatedImages);

    return copyWith(documentsList: updatedDocs);
  }

  bool get isUploading {
    return documentsList.any(
      (doc) => doc.imgs.any((img) => img.imgStatus == UploadStatus.uploading),
    );
  }

  @override
  List<Object?> get props => [proposalNumber, documentsList, fetchStatus];
}
