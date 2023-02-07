import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/entities/chat/room_entity.dart';
import '../models/entities/event/event_entity.dart';
import '../models/enums/load_status.dart';
import '../repositories/auth_repository.dart';
import '../repositories/chat_repository.dart';
import '../repositories/user_repository.dart';
import '../utils/app_stream.dart';
import '../utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  FirestoreRepository firestoreRepo;
  AuthRepository authRepo;
  ChatRepository chatRepo;

  AppCubit({
    required this.firestoreRepo,
    required this.authRepo,
    required this.chatRepo,
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
      print("Fetch User Data: $error");
      emit(state.copyWith(fetchProfileStatus: LoadStatus.failure));
    }
  }

  void fetchEventNotAccepted() async {
    try {
      final listEventNotAccepted = await firestoreRepo.fetchEventNotAccepted();
      emit(state.copyWith(listEventNotAccepted: listEventNotAccepted));
    } catch (error) {

    }
  }

  void fetchEventAccepted() async {
    try {
      final listEventAccepted = await firestoreRepo.fetchEventAccepted();
      emit(state.copyWith(listEventAccepted: listEventAccepted));
    } catch (error) {

    }
  }

  void fetchListUser() async {
    emit(state.copyWith(fetchListUserStatus: LoadStatus.loading));
    try {
      final List<MyUserEntity> listUser = await firestoreRepo.fetchListUserData();
      emit(state.copyWith(fetchListUserStatus: LoadStatus.success, listMember: listUser));

      AppStream.memberChanged.stream.listen((event) async {
        final List<MyUserEntity> listUser = await firestoreRepo.fetchListUserData();
        emit(state.copyWith(listMember: listUser));
      });
    } catch(error) {
      emit(state.copyWith(fetchListUserStatus: LoadStatus.failure));
    }
  }

  void fetchListRoomHasMe(String uid) async {
    try {
      final List<Room> listRoomHasMe = await chatRepo.fetchListRoomHasMe(uid);
      emit(state.copyWith(listRoomHasMe: listRoomHasMe));

      AppStream.roomChanged.stream.listen((event) async {
        final result = await chatRepo.fetchListRoomHasMe(uid);
        emit(state.copyWith(listRoomHasMe: result));
      });

    } catch(error) {}
  }

  void createRoomChat(String currentUid, String guestUid) async {
    try {
      await chatRepo.createRoomChat(currentUid, guestUid);
      fetchListRoomHasMe(currentUid);
    } catch(error) {}
  }
  
  void changedStateFirstLogin(bool isFirstLogin) {
    emit(state.copyWith(firstLogin: isFirstLogin));
  }

  bool isFirstLogin() {
    return state.firstLogin;
  }
  
  Future updateProfile(MyUserEntity user) async {
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

  void acceptEvent(String? id) async {
    try {
      await firestoreRepo.acceptEventRequest(id!);
      fetchEventAccepted();
      fetchEventNotAccepted();
    } catch(error) {}
  }

  void rejectEvent(String? id) async {
    try {
      await firestoreRepo.rejectEventRequest(id!);
      fetchEventNotAccepted();
      fetchEventAccepted();
    } catch(error) {}
  }

}
