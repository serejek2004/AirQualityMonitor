import 'package:first_flutter_project/services/helpers/mqtt_initializer.dart';
import 'package:first_flutter_project/services/helpers/preferences_helper.dart';
import 'package:first_flutter_project/services/not_abstract/device_service.dart';
import 'package:first_flutter_project/services/not_abstract/mqtt_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_input.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceLoginPage extends StatefulWidget {
  const DeviceLoginPage({super.key});

  @override
  DeviceLoginPageState createState() => DeviceLoginPageState();
}

class DeviceLoginPageState extends State<DeviceLoginPage> {
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late MQTTService _mqttService;
  late DeviceService _deviceService;
  String response = '';
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _deviceService = Provider.of<DeviceService>(context, listen: false);
      _initializeMQTT();
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _initializeMQTT() async {
    final data = await getLoginAndTempId();
    final tempId = data['tempId'];
    if (tempId == null) return;

    _mqttService = await _initAuthMQTT(tempId);
  }

  Future<MQTTService> _initAuthMQTT(String tempId) async {
    return await initializeAuthMQTT(
      tempId: tempId,
      onMessageReceived: (topic, message) {
        if (topic == 'device/auth/$tempId') {
          setState(() {
            response = message;
          });
        }
      },
    );
  }

  Future<void> _login() async {
    final data = await getLoginAndTempId();
    final login = data['login'];
    final tempId = data['tempId'];
    if (tempId == null || login == null) return;

    final payload = {
      'login': _loginController.text.trim(),
      'password': _passwordController.text.trim(),
    };

    _mqttService.publish('device/auth/$tempId', payload);
    await Future<void>.delayed(const Duration(seconds: 5));

    if (response == 'ok') {
      await _deviceService.saveDeviceId(tempId);
    }

    await _deviceService.tempDeleteDeviceId();
    _navigateToHome();
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<NetworkService>().isConnected;

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
                    title: 'Device login',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    textColor: customColor,
                  ),
                  const SizedBox(height: 5),
                  CustomInput(
                    label: 'Device login',
                    obscureText: false,
                    fieldWidth: 350,
                    textColor: customColor,
                    cursorColor: customColor,
                    focusedBorderColor: customColor,
                    controller: _loginController,
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    title: 'Device password',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    textColor: customColor,
                  ),
                  const SizedBox(height: 5),
                  CustomInput(
                    label: 'Device password',
                    obscureText: true,
                    fieldWidth: 350,
                    textColor: customColor,
                    cursorColor: customColor,
                    focusedBorderColor: customColor,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  if (isConnected)
                    CustomButton(
                      buttonText: 'Connect',
                      onPressed: _login,
                      width: 150,
                      height: 50,
                      backgroundColor: customColor,
                      textColor: Colors.black,
                    )
                  else
                    const CustomText(
                      title: 'No Internet connection',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: Colors.red,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
