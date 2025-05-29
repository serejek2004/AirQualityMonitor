import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/services/abstract/user_service.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final UserService userService;

  RegistrationCubit({required this.userService}) : super(RegistrationInitial());

  Future<void> register(
      String login, 
      String password, 
      String confirmPassword,
    ) async {
    if (login.length < 3 || login.length > 20) {
      emit(
        const RegistrationError('Login must be between 3 and 20 characters'),
      );
      return;
    }

    if (password.length < 8 || password.length > 20) {
      emit(
        const RegistrationError('Password must be between 8 and 20 characters'),
      );
      return;
    }

    if (password != confirmPassword) {
      emit(const RegistrationError('Passwords do not match'));
      return;
    }

    emit(RegistrationLoading());

    final isRegistered = await userService.registerUser(login, password);

    if (isRegistered) {
      emit(RegistrationSuccess());
    } else {
      emit(
        const RegistrationError('User already exists. Try a different login.'),
      );
    }
  }
}
