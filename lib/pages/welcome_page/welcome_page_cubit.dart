import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeState {
  final bool isConnected;

  const WelcomeState({required this.isConnected});
}

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit(bool initialConnection)
      : super(WelcomeState(isConnected: initialConnection));

  void updateConnection(bool status) {
    emit(WelcomeState(isConnected: status));
  }
}
