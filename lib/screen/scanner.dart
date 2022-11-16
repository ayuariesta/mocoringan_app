import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerQRCode extends StatefulWidget {
  const ScannerQRCode({super.key});

  @override
  State<ScannerQRCode> createState() => _ScannerQRCodeState();
}

class _ScannerQRCodeState extends State<ScannerQRCode> {
  final GlobalKey qrKey = GlobalKey();
  String barcode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: (controller) {
                  controller.scannedDataStream.listen((value) {
                    setState(() {
                      barcode = value as String;
                    });
                  });
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Text("Hasil: $barcode"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
