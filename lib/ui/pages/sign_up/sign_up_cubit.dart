import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

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
  final FirestoreRepository firestoreRepo;
  final AppCubit appCubit;

  SignUpCubit({
    required this.authRepo,
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

  void changeDisplayName({required String displayName}) {
    emit(state.copyWith(displayName: displayName));
  }

  void changeDoB({required DateTime dateOfBirth}) {
    emit(state.copyWith(dateOfBirth: dateOfBirth));
  }

  void changePhoneNumber({required String phoneNumber}) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void changePosition({required String? position}) {
    emit(state.copyWith(position: position));
  }

  void changeDepartment({required String? department}) {
    emit(state.copyWith(department: department));
  }

  void changeEmployeeNumber({required String employeeNumber}) {
    emit(state.copyWith(employeeNumber: employeeNumber));
  }

  Future signUpWithEmail() async {
    final email = state.email ?? '';
    final password = state.password ?? '';
    final passwordConfirm = state.passwordConfirm ?? '';
    final displayName = state.displayName ?? '';
    final phoneNumber = state.phoneNumber ?? '';
    final employeeNumber = state.employeeNumber ?? '';

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

    if (displayName.isEmpty) {
      AppSnackbar.showError(message: 'Display name is empty');
      return;
    }

    if (phoneNumber.isEmpty) {
      AppSnackbar.showError(message: 'Phone number is empty');
      return;
    }

    if (employeeNumber.isEmpty) {
      AppSnackbar.showError(message: 'Employee number is empty');
      return;
    }

    emit(state.copyWith(signUpStatus: LoadStatus.loading));
    try {
      final resultSignUp = await authRepo.registerEmail(email, password);
      if (resultSignUp != null) {
        firestoreRepo.createUserData(
          uid: resultSignUp.uid,
          name: state.displayName,
          email: resultSignUp.email,
          urlAvatar: resultSignUp.photoURL,
          phoneNumber: state.phoneNumber,
          position: state.position,
          department: state.department,
          employeeNumber: state.employeeNumber,
          dateOfBirth: state.dateOfBirth,
        );

        appCubit.fetchProfile(resultSignUp.uid);
        appCubit.fetchListUser();
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
