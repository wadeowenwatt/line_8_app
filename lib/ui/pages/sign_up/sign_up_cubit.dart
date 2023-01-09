import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../blocs/app_cubit.dart';
import '../../../models/enums/load_status.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/firestore_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../../router/route_config.dart';
import '../../commons/app_snackbar.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final FirestoreRepository firestoreRepo;
  final AppCubit appCubit;

  SignUpCubit({
    required this.authRepo,
    required this.userRepo,
    required this.appCubit,
    required this.firestoreRepo,
  }) : super(const SignUpState());

  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void changeConfirmPassword({required String confirmPassword}) {
    emit(state.copyWith(passwordConfirm: confirmPassword));
  }

  Future signUpWithEmail() async {
    final email = state.email ?? '';
    final password = state.password ?? '';
    final passwordConfirm = state.passwordConfirm ?? '';

    if (email.isEmpty) {
      AppSnackbar.showError(message: 'Email is empty');
      return;
    }

    if (password.isEmpty) {
      AppSnackbar.showError(message: 'Password is empty');
      return;
    }

    if (passwordConfirm != password) {
      AppSnackbar.showError(
          message: 'Password Confirm is not match with Password');
      return;
    }

    emit(state.copyWith(signUpStatus: LoadStatus.loading));
    try {
      final resultSignUp = await authRepo.registerEmail(email, password);
      if (resultSignUp != null) {
        firestoreRepo.updateUserData(
          resultSignUp.uid,
          resultSignUp.displayName ?? "Unknown",
          resultSignUp.email,
          "999",
        );
        emit(state.copyWith(signUpStatus: LoadStatus.success));
        Get.offAllNamed(RouteConfig.main);
      } else {
        emit(state.copyWith(signUpStatus: LoadStatus.failure));
      }
    } catch (error) {
      print("$error register failed!");
      emit(state.copyWith(signUpStatus: LoadStatus.failure));
    }
  }
}
