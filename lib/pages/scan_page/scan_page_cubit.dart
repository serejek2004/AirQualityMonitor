import 'package:flutter_bloc/flutter_bloc.dart';

class ScanState {
  final bool isConnected;
  final bool isScanned;

  const ScanState({required this.isConnected, required this.isScanned});

  ScanState copyWith({bool? isConnected, bool? isScanned}) {
    return ScanState(
      isConnected: isConnected ?? this.isConnected,
      isScanned: isScanned ?? this.isScanned,
    );
  }
}

class ScanCubit extends Cubit<ScanState> {
  ScanCubit({required bool initialConnection})
      : super(ScanState(isConnected: initialConnection, isScanned: false));

  void setScanned() => emit(state.copyWith(isScanned: true));

  void updateConnection(bool value) => emit(state.copyWith(isConnected: value));
}
