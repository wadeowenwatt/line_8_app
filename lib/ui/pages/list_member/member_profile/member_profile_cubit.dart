import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../models/entities/user/my_user_entity.dart';
import '../../../../models/enums/load_status.dart';
import '../../../../repositories/firestore_repository.dart';

part 'member_profile_state.dart';

class MemberProfileCubit extends Cubit<MemberProfileState> {
  FirestoreRepository firestoreRepo;

  MemberProfileCubit({
    required this.firestoreRepo,
  }) : super(const MemberProfileState());

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

}
