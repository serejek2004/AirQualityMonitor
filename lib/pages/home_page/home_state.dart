part of 'home_page_cubit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isDeviceConnected;
  final double temperature;
  final double humidity;

  const HomeState({
    required this.isLoading,
    required this.isDeviceConnected,
    required this.temperature,
    required this.humidity,
  });

  const HomeState.initial()
      : isLoading = true,
        isDeviceConnected = false,
        temperature = 0,
        humidity = 0;

  HomeState copyWith({
    bool? isLoading,
    bool? isDeviceConnected,
    double? temperature,
    double? humidity,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isDeviceConnected: isDeviceConnected ?? this.isDeviceConnected,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
    );
  }

  @override
  List<Object> get props => [
    isLoading, 
    isDeviceConnected, 
    temperature, 
    humidity,
  ];
}
