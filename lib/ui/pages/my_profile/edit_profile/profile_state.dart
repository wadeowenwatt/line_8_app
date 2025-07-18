import 'package:equatable/equatable.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:image_picker/image_picker.dart';

class ProfileState extends Equatable {
  final LoadStatus updateDataStatus;
  final String? email;
  final String? displayName;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? employeeNumber;
  final String? position;
  final String? department;
  final String? urlAvatar;
  final XFile? tempAvatar;

  const ProfileState({
    this.updateDataStatus = LoadStatus.initial,
    this.email,
    this.displayName,
    this.dateOfBirth,
    this.phoneNumber,
    this.employeeNumber,
    this.position,
    this.department,
    this.urlAvatar,
    this.tempAvatar,
  });

  ProfileState copyWith(
      {LoadStatus? updateDataStatus,
      String? email,
      String? displayName,
      DateTime? dateOfBirth,
      String? phoneNumber,
      String? employeeNumber,
      String? position,
      String? department,
      String? urlAvatar,
      XFile? tempAvatar}) {
    return ProfileState(
      updateDataStatus: updateDataStatus ?? this.updateDataStatus,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      position: position ?? this.position,
      department: department ?? this.department,
      urlAvatar: urlAvatar ?? this.urlAvatar,
      tempAvatar: tempAvatar ?? this.tempAvatar,
    );
  }

  @override
  List<Object?> get props => [
        updateDataStatus,
        email,
        displayName,
        dateOfBirth,
        phoneNumber,
        employeeNumber,
        position,
        department,
        urlAvatar,
        tempAvatar,
      ];
}
