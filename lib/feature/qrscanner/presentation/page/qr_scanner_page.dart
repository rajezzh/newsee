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
  late bool isGranted = false;

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
      if (status.isGranted) {
        setState(() {
          print('status.isGranted => ${status.isGranted}');
          isGranted = status.isGranted;
        });
      }
    }
    if (status.isGranted) {
      setState(() {
        print('status.isGranted => ${status.isGranted}');
        isGranted = status.isGranted;
      });
    }

    // if (!status.isGranted) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Camera permission is required to scan QR codes'),
    //     ),
    //   );
    //   //  Navigator.pop(context); // Close if permission denied
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('permission granted => $isGranted');
    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner')),
      body:
          isGranted
              ? MobileScanner(
                controller: controller,
                onDetect: (capture) {
                  print('Barcode capture: ${capture.barcodes}');
                  final String? code = capture.barcodes.first.rawValue;
                  if (code != null) {
                    print('QR Code detected: $code');
                    widget.onQRScanned(code);
                  } else {
                    print('No valid QR code found');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No QR code detected')),
                    );
                  }
                },
                errorBuilder: (context, exception) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'Error: ${exception.toString()}',
                          style: TextStyle(color: Colors.red),
                        ),
                        TextButton(
                          onPressed: _checkCameraPermission,
                          child: Text('Request Camera Permission'),
                        ),
                      ],
                    ),
                  );
                },
              )
              : TextButton(
                onPressed: _checkCameraPermission,
                child: Text('Request Camera Permission'),
              ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
