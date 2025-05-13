import 'dart:async';
import 'package:first_flutter_project/services/not_abstract/mqtt_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
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

  late MQTTService _mqttService;

  @override
  void initState() {
    super.initState();
    _initializeMqtt();
  }

  void _initializeMqtt() {
    _mqttService = MQTTService(
      broker: '758419f9f9db440997781986174fedf9.s1.eu.hivemq.cloud',
      username: 'publisher',
      password: 'Hello1234',
      topics: ['sensors/temperature', 'sensors/humidity'],
      onMessageReceived: (topic, message) {
        setState(() {
          if (topic == 'sensors/temperature') {
            temp = double.tryParse(message) ?? 5;
          } else if (topic == 'sensors/humidity') {
            humidity = double.tryParse(message) ?? 5;
          }
        });
      },
    );

    _mqttService.connect();
  }

  @override
  void dispose() {
    _mqttService.disconnect();
    super.dispose();
  }

  Future<void> _confirmLogout(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: customColor,
          content: const CustomText(
            title: 'Are you sure?',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            textColor: Colors.white,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const CustomText(
                title: 'Cancel',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () async {
                await _logout(context);
              },
              child: const CustomText(
                title: 'Logout',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                textColor: Colors.redAccent,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionLogin');
    await prefs.remove('sessionPassword');
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
    }
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title: 'Air quality monitor',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    textColor: customColor,
                  ),
                  const SizedBox(height: 20),
                  if (isConnected) ...[
                    SizedBox(
                      width: 350,
                      child: CustomText(
                        title:
                            'Temperature: ${temp.toStringAsFixed(2)} °C\n'
                            'Humidity: ${humidity.toStringAsFixed(2)} %\n',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        textColor: customColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            buttonText: 'Profile',
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/profile',
                                (route) => true,
                              );
                            },
                            width: 150,
                            height: 50,
                            backgroundColor: customColor,
                            textColor: Colors.black,
                          ),
                          CustomButton(
                            buttonText: 'Logout',
                            onPressed: () => _confirmLogout(context),
                            width: 150,
                            height: 50,
                            backgroundColor: customColor,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ]
                  else ...[
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
