import 'package:flutter_base/models/entities/user/my_user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/app_cubit.dart';
import '../../../../repositories/firestore_repository.dart';
import '../../../commons/app_snackbar.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirestoreRepository firestoreRepo;
  final AuthRepository authRepo;
  final AppCubit appCubit;

  ProfileCubit({
    required this.firestoreRepo,
    required this.authRepo,
    required this.appCubit,
  }) : super(const ProfileState());

  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
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

  void updateDataUserToFirestore() async {
    final email = state.email ?? '';
    final displayName = state.displayName ?? '';
    final phoneNumber = state.phoneNumber ?? '';
    final employeeNumber = state.employeeNumber ?? '';

    if (displayName.isEmpty) {
      AppSnackbar.showError(message: 'Display name is empty');
      return;
    }

    if (employeeNumber.isEmpty) {
      AppSnackbar.showError(message: 'Employee number is empty');
      return;
    }

    if (phoneNumber.isEmpty) {
      AppSnackbar.showError(message: 'Phone number is empty');
      return;
    }

    if (email.isEmpty) {
      AppSnackbar.showError(message: 'Email is empty');
      return;
    }



    emit(state.copyWith(updateDataStatus: LoadStatus.loading));
    try {
      // final currentUser = authRepo.getUser();
      // appCubit.updateProfile(user);
    } catch (error) {
      return;
    }
  }
}
