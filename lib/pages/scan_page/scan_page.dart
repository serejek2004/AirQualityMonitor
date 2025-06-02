import 'package:first_flutter_project/pages/scan_page/scan_page_cubit.dart';
import 'package:first_flutter_project/services/not_abstract/device_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isInitiallyConnected = context.read<NetworkService>().isConnected;

    return BlocProvider(
      create: (_) => ScanCubit(initialConnection: isInitiallyConnected),
      child: Builder(
        builder: (context) {
          final isConnected = context.watch<NetworkService>().isConnected;
          context.read<ScanCubit>().updateConnection(isConnected);

          return BlocBuilder<ScanCubit, ScanState>(
            builder: (context, state) {
              return Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    const BackgroundImage(),
                    if (state.isConnected)
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
                                  onDetect: (capture) async {
                                    if (state.isScanned) return;
                                    final barcode = capture.barcodes.first;
                                    final code = barcode.rawValue;
                                    if (code != null) {
                                      context.read<ScanCubit>().setScanned();
                                      await DeviceService(
                                        ).tempSaveDeviceId(code);
                                      if (context.mounted) {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/device',
                                          (route) => true,
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                        255, 103, 167, 235,
                                      ),
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
            },
          );
        },
      ),
    );
  }
}
