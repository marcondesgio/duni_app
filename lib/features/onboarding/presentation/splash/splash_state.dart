enum SplashStatus { loading, ready }

class SplashState {
  const SplashState({this.status = SplashStatus.loading});

  final SplashStatus status;

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }
}
