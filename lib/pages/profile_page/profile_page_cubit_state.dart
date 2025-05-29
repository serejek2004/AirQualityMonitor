class ProfileState {
  final String? login;
  final Map<String, double>? settings;
  final bool isLoading;

  const ProfileState({
    this.login,
    this.settings,
    this.isLoading = true,
  });

  ProfileState copyWith({
    String? login,
    Map<String, double>? settings,
    bool? isLoading,
  }) {
    return ProfileState(
      login: login ?? this.login,
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
