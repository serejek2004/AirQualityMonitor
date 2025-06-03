import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/services/helpers/mqtt_initializer.dart';
import 'package:first_flutter_project/services/helpers/preferences_helper.dart';
import 'package:first_flutter_project/services/not_abstract/device_service.dart';
import 'package:first_flutter_project/services/not_abstract/mqtt_service.dart';

part 'device_login_state.dart';

class DeviceLoginCubit extends Cubit<DeviceLoginState> {
  final DeviceService deviceService;
  late MQTTService mqttService;

  DeviceLoginCubit({required this.deviceService}) : super(DeviceLoginInitial());

  Future<void> initializeMQTT() async {
    final data = await getLoginAndTempId();
    final tempId = data['tempId'];

    if (tempId == null) {
      emit(DeviceLoginFailure('Temp ID is missing during MQTT initialization'));
      return;
    }

    mqttService = await initializeAuthMQTT(
      tempId: tempId,
      onMessageReceived: (topic, message) {
        if (topic == 'device/auth/$tempId') {
          emit(DeviceLoginSuccess());
        }
      },
    );
  }

  Future<void> login(String loginInput, String passwordInput) async {
    emit(DeviceLoginLoading());

    final data = await getLoginAndTempId();
    final tempId = data['tempId'];

    if (tempId == null) {
      emit(DeviceLoginFailure('Temp ID is missing during login'));
      return;
    }

    final payload = {
      'login': loginInput.trim(),
      'password': passwordInput.trim(),
    };

    mqttService.publish('device/auth/$tempId', payload);

    await Future<void>.delayed(const Duration(seconds: 5));

    if (state is DeviceLoginSuccess) {
      await deviceService.saveDeviceId(tempId);
    }

    await deviceService.tempDeleteDeviceId();
    emit(DeviceLoginCompleted());
  }
}
