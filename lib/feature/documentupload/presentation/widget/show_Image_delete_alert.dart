import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/feature/documentupload/presentation/bloc/document_bloc.dart';
import 'package:newsee/feature/documentupload/presentation/bloc/document_event.dart';

Future<dynamic> confirmAndDeleteImage(
  BuildContext context,
  int docIndex, {
  int? imgIndex,
  String? checkFrom,
}) async {
  try {
    // final bloc = context.read<DocumentBloc>();
    return showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: Text(
              imgIndex != null
                  ? 'Are you sure you want to delete this image?'
                  : 'Are you sure you want to delete all images in this document?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (checkFrom != null) {
                    context.pop(checkFrom);
                  } else {
                    // Navigator.of(ctx).pop();

                    context.read<DocumentBloc>().add(
                      DeleteDocumentImageEvent(
                        docIndex: docIndex,
                        imgIndex: imgIndex,
                      ),
                    );
                    Navigator.pop(ctx);
                  }
                },
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  } catch (e) {
    print("showDeleteAlert: $e");
  }
}
