import 'package:first_flutter_project/pages/home_page/home_page_cubit.dart';
import 'package:first_flutter_project/services/not_abstract/device_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:first_flutter_project/widgets/general/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const customColor = Color.fromARGB(255, 103, 167, 235);

    return BlocProvider(
      create: (_) => HomeCubit(
        deviceService: context.read<DeviceService>(),
        networkService: context.read<NetworkService>(),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: Center(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const CircularProgressIndicator();
                    }

                    final isConnected = 
                      context.read<NetworkService>().isConnected;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const CustomText(
                          title: 'Air quality monitor',
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          textColor: customColor,
                        ),
                        const SizedBox(height: 10),
                        if (isConnected) ...[
                          if (state.isDeviceConnected) ...[
                            SizedBox(
                              width: 350,
                              child: CustomText(
                                title:
                                    'Temperature: ${
                                      state.temperature.toStringAsFixed(2)
                                    } °C\n'
                                    'Humidity: ${
                                      state.humidity.toStringAsFixed(2)
                                    } %',
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                textColor: customColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              buttonText: 'Disconnect device',
                              onPressed: () =>
                                  context.read<HomeCubit>().disconnectDevice(),
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
                                    showLogoutDialog(
                                      context,
                                      () async {
                                        await context.read<HomeCubit>()
                                          .logout();
                                        if (!context.mounted) return;
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, '/welcome', (_) => false,);
                                      },
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
