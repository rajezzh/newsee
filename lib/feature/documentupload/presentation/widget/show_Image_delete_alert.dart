import 'package:flutter/material.dart';

Future<dynamic> confirmAndDeleteImage(BuildContext context) async {
  try {
    return showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this image?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  } catch (e) {
    print("showDeleteAlert: $e");
  }
}
