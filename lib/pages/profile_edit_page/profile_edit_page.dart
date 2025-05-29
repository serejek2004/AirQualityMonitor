import 'package:first_flutter_project/pages/profile_edit_page/profile_edit_cubit.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/services/not_abstract/user_settings_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:first_flutter_project/widgets/profile_edit_page/section_title.dart';
import 'package:first_flutter_project/widgets/profile_edit_page/settings_input_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({super.key});

  final Color customColor = const Color.fromARGB(255, 103, 167, 235);

  final _controllers = {
    'minTemperature': TextEditingController(),
    'maxTemperature': TextEditingController(),
    'minHumidity': TextEditingController(),
    'maxHumidity': TextEditingController(),
    'minCO2': TextEditingController(),
    'maxCO2': TextEditingController(),
  };

  void _fillControllers(Map<String, dynamic> settings) {
    _controllers['minTemperature']!.text = 
      settings['minTemperature'].toString();
    _controllers['maxTemperature']!.text = 
      settings['maxTemperature'].toString();
    _controllers['minHumidity']!.text = 
      settings['minHumidity'].toString();
    _controllers['maxHumidity']!.text = 
      settings['maxHumidity'].toString();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<NetworkService>(context).isConnected;

    return BlocProvider(
      create: (_) =>
          ProfileEditCubit(Provider.of<UserSettingsService>(
            context, listen: false,),)..loadSettings(),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocConsumer<ProfileEditCubit, ProfileEditState>(
                  listener: (context, state) {
                    if (state is ProfileEditSaved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Settings successfully updated'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/profile',
                        (route) => false,
                      );
                    } else if (state is ProfileEditError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfileEditLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ProfileEditLoaded) {
                      _fillControllers(state.settings);
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SectionTitle(
                          title: 'New temperature', 
                          color: customColor,
                        ),
                        SettingsInputRow(
                          controller1: _controllers['minTemperature']!,
                          controller2: _controllers['maxTemperature']!,
                          label1: 'Min temperature',
                          label2: 'Max temperature',
                          color: customColor,
                        ),
                        SectionTitle(title: 'New humidity', color: customColor),
                        SettingsInputRow(
                          controller1: _controllers['minHumidity']!,
                          controller2: _controllers['maxHumidity']!,
                          label1: 'Min humidity',
                          label2: 'Max humidity',
                          color: customColor,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          buttonText: state is ProfileEditSaving ?
                           'Updating...' : 'Update',
                          onPressed: state is ProfileEditSaving
                              ? () {}
                              : () {
                                  context.read<ProfileEditCubit>()
                                  .saveSettings({
                                    'minTemperature': 
                                      _controllers['minTemperature']!.text,
                                    'maxTemperature': 
                                      _controllers['maxTemperature']!.text,
                                    'minHumidity': 
                                      _controllers['minHumidity']!.text,
                                    'maxHumidity':
                                      _controllers['maxHumidity']!.text,
                                  });
                                },
                          width: 150,
                          height: 50,
                          backgroundColor: customColor,
                          textColor: Colors.black,
                        ),
                        if (!isConnected)
                          const CustomText(
                            title: 'No Internet Connection',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
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
