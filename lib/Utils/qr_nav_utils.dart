import 'package:flutter/material.dart';
import 'package:newsee/feature/qrscanner/presentation/page/qr_scanner_page.dart';

void showScannerOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16),
        height: 150,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.qr_code_scanner),
              title: Text('QR Scanner'),
              onTap: () {
                Navigator.pop(context); // Close bottom sheet
                _navigateToQRScanner(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text('OCR'),
              onTap: () {
                Navigator.pop(context); // Close bottom sheet
                // TODO: Implement OCR functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('OCR feature not implemented yet')),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

// Navigate to QR Scanner page
void _navigateToQRScanner(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder:
          (context) => QRScannerPage(
            onQRScanned: (result) {
              _showResultDialog(context, result); // Show result in AlertDialog
            },
          ),
    ),
  );
}

// Show AlertDialog with QR scan result
void _showResultDialog(BuildContext context, String result) {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('QR Scan Result'),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
