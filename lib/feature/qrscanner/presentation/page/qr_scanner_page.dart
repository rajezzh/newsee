import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScannerPage extends StatefulWidget {
  final Function(String) onQRScanned;

  QRScannerPage({required this.onQRScanned});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode], // Explicitly specify QR code format
  );

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera permission is required to scan QR codes'),
        ),
      );
      Navigator.pop(context); // Close if permission denied
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner')),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          print('Barcode capture: ${capture.barcodes}');
          final String? code = capture.barcodes.first.rawValue;
          if (code != null) {
            print('QR Code detected: $code');
            widget.onQRScanned(code);
          } else {
            print('No valid QR code found');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('No QR code detected')));
          }
        },
        errorBuilder: (context, exception) {
          return Center(
            child: Text(
              'Error: ${exception.toString()}',
              style: TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
