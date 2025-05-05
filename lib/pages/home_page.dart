import 'package:first_flutter_project/services/helpers/mqtt_initializer.dart';
import 'package:first_flutter_project/services/not_abstract/device_service.dart';
import 'package:first_flutter_project/services/not_abstract/mqtt_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:first_flutter_project/widgets/general/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);
  double temp = 0;
  double humidity = 0;
  bool isDeviceConnected = false;
  bool isLoading = true;
  MQTTService? _mqttService;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _checkDevice();
    _mqttService = await initializeMQTT((topic, message) {
      setState(() {
        if (topic.contains('temperature')) {
          temp = double.tryParse(message) ?? 0;
        } else if (topic.contains('humidity')) {
          humidity = double.tryParse(message) ?? 0;
        }
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _checkDevice() async {
    final deviceService = Provider.of<DeviceService>(context, listen: false);
    final result = await deviceService.isDevice();
    setState(() {
      isDeviceConnected = result;
    });
  }

  @override
  void dispose() {
    _mqttService?.disconnect();
    super.dispose();
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionLogin');
    await prefs.remove('sessionPassword');
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/welcome', (_) => false);
  }

  Future<void> _disconnectDevice() async {
    final deviceService = Provider.of<DeviceService>(context, listen: false);
    deviceService.disconnect();
    await _checkDevice();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<NetworkService>(context).isConnected;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: 'Air quality monitor',
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          textColor: customColor,
                        ),
                        const SizedBox(height: 10),
                        if (isConnected) ...[
                          if (isDeviceConnected) ...[
                            SizedBox(
                              width: 350,
                              child: CustomText(
                                title:
                                    'Temperature: '
                                    '${temp.toStringAsFixed(2)} °C\n'
                                    'Humidity: '
                                    '${humidity.toStringAsFixed(2)} %',
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                textColor: customColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              buttonText: 'Disconnect device',
                              onPressed: _disconnectDevice,
                              width: 350,
                              height: 50,
                              backgroundColor: customColor,
                              textColor: Colors.black,
                            ),
                          ] else ...[
                            CustomButton(
                              buttonText: 'Connect device',
                              onPressed: () {
                                Navigator.pushNamed(context, '/scan');
                              },
                              width: 350,
                              height: 50,
                              backgroundColor: customColor,
                              textColor: Colors.black,
                            ),
                          ],
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  buttonText: 'Profile',
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/profile');
                                  },
                                  width: 150,
                                  height: 50,
                                  backgroundColor: customColor,
                                  textColor: Colors.black,
                                ),
                                CustomButton(
                                  buttonText: 'Logout',
                                  onPressed: () {
                                    showLogoutDialog(context, 
                                      _logout, 
                                      customColor,
                                    );
                                  },
                                  width: 150,
                                  height: 50,
                                  backgroundColor: customColor,
                                  textColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          const CustomText(
                            title: 'No Internet Connection',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            textColor: Colors.red,
                          ),
                        ],
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
