part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final LoadStatus signUpStatus;
  final String? email;
  final String? password;
  final String? passwordConfirm;
  final String? displayName;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? employeeNumber;
  final String? position;
  final String? department;

  const SignUpState({
    this.signUpStatus = LoadStatus.initial,
    this.email,
    this.password,
    this.passwordConfirm,
    this.displayName,
    this.dateOfBirth,
    this.phoneNumber,
    this.employeeNumber,
    this.position,
    this.department,
  });

  @override
  List<Object?> get props => [
        signUpStatus,
        email,
        password,
        passwordConfirm,
        displayName,
        dateOfBirth,
        phoneNumber,
        employeeNumber,
        position,
        department,
      ];

  SignUpState copyWith({
    LoadStatus? signUpStatus,
    String? email,
    String? password,
    String? passwordConfirm,
    String? displayName,
    DateTime? dateOfBirth,
    String? phoneNumber,
    String? employeeNumber,
    String? position,
    String? department,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      displayName: displayName ?? this.displayName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      position: position ?? this.position,
      department: department ?? this.department,
    );
  }
}
