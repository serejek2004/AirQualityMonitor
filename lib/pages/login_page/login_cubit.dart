import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/services/abstract/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserService userService;

  LoginCubit({required this.userService}) : super(LoginInitial());

  Future<void> login(String login, String password) async {
    emit(LoginLoading());

    final isValidUser = await userService.validateUser(login, password);

    if (isValidUser) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure('Wrong login or password'));
    }
  }
}
