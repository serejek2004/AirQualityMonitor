import 'package:first_flutter_project/services/not_abstract/device_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanned = false;

  void _handleBarcode(BarcodeCapture capture) async {
    if (isScanned) return;
    final Barcode barcode = capture.barcodes.first;
    final String? code = barcode.rawValue;
    if (code != null) {
      isScanned = true;
      await DeviceService().tempSaveDeviceId(code);
      if (!mounted) {
        return;
      }
      else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/device',
          (route) => true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<NetworkService>(context).isConnected;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const BackgroundImage(),
          if (isConnected)
            Center(
              child: SizedBox(
                width: 275,
                height: 275,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: MobileScanner(
                        controller: MobileScannerController(
                          detectionSpeed: DetectionSpeed.noDuplicates,
                        ),
                        onDetect: _handleBarcode,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color.fromARGB(255, 103, 167, 235),
                            width: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            const Center(
              child: CustomText(
                title: 'No Internet Connection',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                textColor: Colors.red,
              ),
            ),
          const SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: CustomText(
                  title: 'Scan QR Code',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
