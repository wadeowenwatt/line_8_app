import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/enums/load_status.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';
import '../utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  UserRepository userRepo;
  AuthRepository authRepo;

  AppCubit({
    required this.userRepo,
    required this.authRepo,
  }) : super(const AppState());

  void fetchProfile() {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
  }

  void updateProfile(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  void signOutGoogle() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await authRepo.signOutGoogle();
      emit(state.removeUser().copyWith(signOutStatus: LoadStatus.success),);
    } catch (e) {
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }

  void signOutEmail() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await authRepo.signOutWithEmail();
      emit(state.removeUser().copyWith(signOutStatus: LoadStatus.success),);
    } catch (e) {
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }
}
