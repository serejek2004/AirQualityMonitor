import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/services/helpers/mqtt_initializer.dart';
import 'package:first_flutter_project/services/not_abstract/device_service.dart';
import 'package:first_flutter_project/services/not_abstract/mqtt_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DeviceService deviceService;
  final NetworkService networkService;

  MQTTService? _mqttService;

  HomeCubit({
    required this.deviceService,
    required this.networkService,
  }) : super(const HomeState.initial()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(isLoading: true));
    final isDevice = await deviceService.isDevice();

    _mqttService = await initializeMQTT((topic, message) {
      double? temp = state.temperature;
      double? humidity = state.humidity;

      if (topic.contains('temperature')) {
        temp = double.tryParse(message) ?? 0;
      } else if (topic.contains('humidity')) {
        humidity = double.tryParse(message) ?? 0;
      }

      emit(state.copyWith(temperature: temp, humidity: humidity));
    });

    emit(state.copyWith(isDeviceConnected: isDevice, isLoading: false));
  }

  Future<void> disconnectDevice() async {
    await deviceService.disconnect();
    final isDevice = await deviceService.isDevice();
    emit(state.copyWith(isDeviceConnected: isDevice));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionLogin');
    await prefs.remove('sessionPassword');
  }

  @override
  Future<void> close() {
    _mqttService?.disconnect();
    return super.close();
  }
}
