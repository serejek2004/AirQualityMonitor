part of 'device_login_cubit.dart';

abstract class DeviceLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeviceLoginInitial extends DeviceLoginState {}

class DeviceLoginLoading extends DeviceLoginState {}

class DeviceLoginSuccess extends DeviceLoginState {}

class DeviceLoginCompleted extends DeviceLoginState {}

class DeviceLoginFailure extends DeviceLoginState {
  final String errorMessage;

  DeviceLoginFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
