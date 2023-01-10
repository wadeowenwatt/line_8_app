import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/commons/app_snackbar.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../repositories/user_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepo;
  final FirestoreRepository firestoreRepo;
  final AppCubit appCubit;

  SignInCubit({
    required this.authRepo,
    required this.appCubit,
    required this.firestoreRepo,
  }) : super(const SignInState());

  void changeUsername({required String username}) {
    emit(state.copyWith(username: username));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(signInWithGoogleStatus: LoadStatus.loading));
    try {
      final result = await authRepo.signInWithGoogle();

      if (result != null) {
        appCubit.fetchProfile(result.uid);

        final creationTime = result.metadata.creationTime;
        final lastSignInTime = result.metadata.lastSignInTime;
        if (creationTime!.year.compareTo(lastSignInTime!.year) == 0 &&
            creationTime.month.compareTo(lastSignInTime.month) == 0 &&
            creationTime.day.compareTo(lastSignInTime.day) == 0 &&
            creationTime.hour.compareTo(lastSignInTime.hour) == 0 &&
            creationTime.minute.compareTo(lastSignInTime.minute) == 0 &&
            creationTime.second.compareTo(lastSignInTime.second) == 0) {
          firestoreRepo.createUserData(
            result.uid,
            result.displayName,
            result.email,
            result.photoURL,
            result.phoneNumber,
          );
        }
        emit(state.copyWith(signInWithGoogleStatus: LoadStatus.success));
        Get.offNamed(RouteConfig.main);
      } else {
        emit(state.copyWith(signInWithGoogleStatus: LoadStatus.failure));
      }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signInWithGoogleStatus: LoadStatus.failure));
    }
  }

  /// Don't need email,pwd because we handle it in sign_in_state
  Future signInWithEmail() async {
    final username = state.username ?? '';
    final password = state.password ?? '';
    if (username.isEmpty) {
      AppSnackbar.showError(message: 'Email is empty');
      return;
    }
    if (password.isEmpty) {
      AppSnackbar.showError(message: 'Password is empty');
      return;
    }
    emit(state.copyWith(signInWithEmailStatus: LoadStatus.loading));
    try {
      final result = await authRepo.signInWithEmail(username, password);
      if (result != null) {
        appCubit.fetchProfile(result.uid);
        emit(state.copyWith(signInWithEmailStatus: LoadStatus.success));
        Get.offNamed(RouteConfig.main);
      } else {
        emit(state.copyWith(signInWithEmailStatus: LoadStatus.failure));
      }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signInWithGoogleStatus: LoadStatus.failure));
    }
  }
}
