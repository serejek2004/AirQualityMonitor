import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/services/not_abstract/user_settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final UserSettingsService settingsService;

  ProfileEditCubit(this.settingsService) : super(ProfileEditInitial());

  Future<void> loadSettings() async {
    emit(ProfileEditLoading());
    try {
      final settings = await settingsService.getUserSettings();
      emit(ProfileEditLoaded(settings: settings));
    } catch (e) {
      emit(ProfileEditError(message: 'Error loading settings'));
    }
  }

  Future<void> saveSettings(Map<String, String> values) async {
    emit(ProfileEditSaving());
    try {
      final prefs = await SharedPreferences.getInstance();
      final login = prefs.getString('sessionLogin') ?? '';

      await settingsService.setMinTemperature(
        double.parse(values['minTemperature']!),
        login,
      );
      await settingsService.setMaxTemperature(
        double.parse(values['maxTemperature']!),
        login,
      );
      await settingsService.setMinHumidity(
        double.parse(values['minHumidity']!),
        login,
      );
      await settingsService.setMaxHumidity(
        double.parse(values['maxHumidity']!),
        login,
      );

      emit(ProfileEditSaved());
    } catch (e) {
      emit(ProfileEditError(message: 'Error saving settings'));
    }
  }
}
