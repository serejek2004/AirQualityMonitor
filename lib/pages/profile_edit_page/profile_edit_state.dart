part of 'profile_edit_cubit.dart';

abstract class ProfileEditState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileEditInitial extends ProfileEditState {}

class ProfileEditLoading extends ProfileEditState {}

class ProfileEditLoaded extends ProfileEditState {
  final Map<String, dynamic> settings;

  ProfileEditLoaded({required this.settings});

  @override
  List<Object?> get props => [settings];
}

class ProfileEditSaving extends ProfileEditState {}

class ProfileEditSaved extends ProfileEditState {}

class ProfileEditError extends ProfileEditState {
  final String message;

  ProfileEditError({required this.message});

  @override
  List<Object?> get props => [message];
}
