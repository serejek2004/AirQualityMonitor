import 'package:first_flutter_project/pages/profile_page/profile_page_cubit.dart';
import 'package:first_flutter_project/pages/profile_page/profile_page_cubit_state.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/services/not_abstract/user_settings_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:first_flutter_project/widgets/profile_page_widgets/buttons.dart';
import 'package:first_flutter_project/widgets/profile_page_widgets/greeting_user.dart';
import 'package:first_flutter_project/widgets/profile_page_widgets/profile_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userSettingsService = Provider.of<UserSettingsService>(
      context, 
      listen: false,
    );
    final isConnected = Provider.of<NetworkService>(context).isConnected;

    return BlocProvider(
      create: (_) => ProfileCubit(userSettingsService: userSettingsService)
        ..loadUserData(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                const BackgroundImage(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: state.isLoading || state.settings == null
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildGreeting(state.login),
                              const SizedBox(height: 40),
                              ProfileInfoRow(
                                label: 'Temperature',
                                minValue: state.settings!['minTemperature'],
                                maxValue: state.settings!['maxTemperature'],
                              ),
                              const SizedBox(height: 20),
                              ProfileInfoRow(
                                label: 'Humidity',
                                minValue: state.settings!['minHumidity'],
                                maxValue: state.settings!['maxHumidity'],
                              ),
                              const SizedBox(height: 40),
                              if (isConnected)
                                buildButtons(context)
                              else
                                const CustomText(
                                  title: 'No Internet Connection',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  textColor: Colors.red,
                                ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
