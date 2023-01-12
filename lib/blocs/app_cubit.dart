import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/enums/load_status.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  FirestoreRepository firestoreRepo;
  AuthRepository authRepo;

  AppCubit({
    required this.firestoreRepo,
    required this.authRepo,
  }) : super(const AppState());

  void fetchProfile(String uid) async {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
    try {
      final myUserEntity = await firestoreRepo.fetchUserData(uid);
      if (myUserEntity != null) {
        emit(state.copyWith(fetchProfileStatus: LoadStatus.success, user: myUserEntity));
      } else {
        emit(state.copyWith(fetchProfileStatus: LoadStatus.failure));
      }
    } catch(error) {
      print("$error fetch user data failed!");
      emit(state.copyWith(fetchProfileStatus: LoadStatus.failure));
    }
  }

  void updateProfile(MyUserEntity user) async {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
    try {
      await firestoreRepo.updateDataUser(userUpdate: user);
      final myUserEntity = await firestoreRepo.fetchUserData(user.uid);
      emit(state.copyWith(fetchProfileStatus: LoadStatus.success, user: myUserEntity));
    } catch(error) {
      print("$error fetch user data failed!");
      emit(state.copyWith(fetchProfileStatus: LoadStatus.failure));
    }
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
