import 'package:first_flutter_project/pages/device_login_page/device_login_cubit.dart';
import 'package:first_flutter_project/services/not_abstract/device_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_input.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceLoginPage extends StatelessWidget {
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DeviceLoginCubit _cubit;

  DeviceLoginPage({required DeviceService deviceService, super.key})
      : _cubit = DeviceLoginCubit(
        deviceService: deviceService,
      )..initializeMQTT();

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<NetworkService>().isConnected;

    return BlocProvider<DeviceLoginCubit>.value(
      value: _cubit,
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: Center(
                child: BlocConsumer<DeviceLoginCubit, DeviceLoginState>(
                  listener: (context, state) {
                    if (state is DeviceLoginCompleted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (_) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
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
                            buttonText: state is DeviceLoginLoading
                                ? 'Connecting...'
                                : 'Connect',
                            onPressed: state is DeviceLoginLoading
                                ? null
                                : () {
                                    _cubit.login(
                                      _loginController.text,
                                      _passwordController.text,
                                    );
                                  },
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
