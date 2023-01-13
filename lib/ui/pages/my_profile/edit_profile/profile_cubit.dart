import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../blocs/app_cubit.dart';
import '../../../../repositories/firestorage_repository.dart';
import '../../../../repositories/firestore_repository.dart';
import '../../../../router/route_config.dart';
import '../../../commons/app_snackbar.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirestoreRepository firestoreRepo;
  final AuthRepository authRepo;
  final FireStorageRepository storageRepo;
  final AppCubit appCubit;

  ProfileCubit({
    required this.firestoreRepo,
    required this.authRepo,
    required this.appCubit,
    required this.storageRepo,
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

  Future updateDataUserToFirestore() async {
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
      AppDialog.showLoadingDialog();
      final currentUser = await authRepo.getUser();
      if (currentUser != null) {
        if (state.tempAvatar != null) {
          await storageRepo
              .uploadImage(state.tempAvatar)
              .then((result) => emit(state.copyWith(urlAvatar: result)));
        }
        final uidCurrentUser = currentUser.uid;
        final MyUserEntity userUpdate = MyUserEntity(
            uid: uidCurrentUser,
            name: state.displayName,
            email: state.email,
            urlAvatar: state.urlAvatar ?? appCubit.state.user?.urlAvatar,
            phoneNumber: state.phoneNumber,
            employeeNumber: state.employeeNumber,
            dateOfBirth: Timestamp.fromDate(state.dateOfBirth as DateTime),
            department: state.department,
            position: state.position);
        await appCubit.updateProfile(userUpdate);
        emit(state.copyWith(updateDataStatus: LoadStatus.success));
        Get.back();
      }
    } catch (error) {
      return;
    }
  }

  void pickImageGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    emit(state.copyWith(tempAvatar: image));
  }

  void pickImageCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    emit(state.copyWith(tempAvatar: image));
  }
}
