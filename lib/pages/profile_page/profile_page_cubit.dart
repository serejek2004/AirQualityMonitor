import 'package:first_flutter_project/pages/profile_page/profile_page_cubit_state.dart';
import 'package:first_flutter_project/services/not_abstract/user_settings_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserSettingsService userSettingsService;

  ProfileCubit({required this.userSettingsService})
      : super(const ProfileState());

  Future<void> loadUserData() async {
    emit(state.copyWith(isLoading: true));
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('sessionLogin');
    final settings = await userSettingsService.getUserSettings();
    emit(ProfileState(login: login, settings: settings, isLoading: false));
  }
}
