part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? username;
  final String? password;
  final LoadStatus signInWithGoogleStatus;

  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.username,
    this.password,
    this.signInWithGoogleStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        signInStatus,
        signInWithGoogleStatus,
        username,
        password,
      ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    LoadStatus? signInWithGoogleStatus,
    String? username,
    String? password,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      signInWithGoogleStatus: signInWithGoogleStatus ?? this.signInWithGoogleStatus,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
