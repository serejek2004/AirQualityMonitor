import 'package:first_flutter_project/services/not_abstract/user_settings_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/profile_edit_page/section_title.dart';
import 'package:first_flutter_project/widgets/profile_edit_page/settings_input_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> {
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);

  final _controllers = {
    'minTemperature': TextEditingController(),
    'maxTemperature': TextEditingController(),
    'minHumidity': TextEditingController(),
    'maxHumidity': TextEditingController(),
    'minCO2': TextEditingController(),
    'maxCO2': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
    
  }

  Future<void> _loadSettings() async {
    final settingsService = 
      Provider.of<UserSettingsService>(context, listen: false);
    final settings = await settingsService.getUserSettings();
    _controllers['minTemperature']!.text = 
      settings['minTemperature'].toString();
    _controllers['maxTemperature']!.text = 
      settings['maxTemperature'].toString();
    _controllers['minHumidity']!.text = settings['minHumidity'].toString();
    _controllers['maxHumidity']!.text = settings['maxHumidity'].toString();
    _controllers['minCO2']!.text = settings['minCO2'].toString();
    _controllers['maxCO2']!.text = settings['maxCO2'].toString();
    setState(() {});
  }

  Future<void> _saveSettings() async {
    final settingsService = 
      Provider.of<UserSettingsService>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final String? login = prefs.getString('sessionLogin');
    try {
      await settingsService.setMinTemperature(
        double.parse(_controllers['minTemperature']!.text),
        login.toString(),
      );
      await settingsService.setMaxTemperature(
        double.parse(_controllers['maxTemperature']!.text),
        login.toString(),
      );
      await settingsService.setMinHumidity(
        double.parse(_controllers['minHumidity']!.text),
        login.toString(),
      );
      await settingsService.setMaxHumidity(
        double.parse(_controllers['maxHumidity']!.text),
        login.toString(),
      );
      await settingsService.setMinCO2(
        double.parse(_controllers['minCO2']!.text),
        login.toString(),
      );
      await settingsService.setMaxCO2(
        double.parse(_controllers['maxCO2']!.text),
        login.toString(),
      );

      if (!mounted) return;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings successfully updated'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error saving settings'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SectionTitle(title: 'New temperature', color: customColor),
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
                  SectionTitle(title: 'New CO2', color: customColor),
                  SettingsInputRow(
                    controller1: _controllers['minCO2']!,
                    controller2: _controllers['maxCO2']!,
                    label1: 'Min CO2',
                    label2: 'Max CO2',
                    color: customColor,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    buttonText: 'Update',
                    onPressed: _saveSettings,
                    width: 150,
                    height: 50,
                    backgroundColor: customColor,
                    textColor: Colors.black,
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
