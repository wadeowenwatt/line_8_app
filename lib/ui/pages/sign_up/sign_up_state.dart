part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final LoadStatus signUpStatus;
  final String? email;
  final String? password;
  final String? passwordConfirm;

  const SignUpState({
    this.signUpStatus = LoadStatus.initial,
    this.email,
    this.password,
    this.passwordConfirm,
  });

  @override
  List<Object?> get props => [
        signUpStatus,
        email,
        password,
        passwordConfirm,
      ];

  SignUpState copyWith({
    LoadStatus? signUpStatus,
    String? email,
    String? password,
    String? passwordConfirm,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
    );
  }
}
