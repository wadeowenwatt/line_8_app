import 'package:cloud_firestore/cloud_firestore.dart';

class MyUserEntity {
  final String uid;
  final String name;
  final String urlAvatar;
  final int employeeNumber;
  final Timestamp dateOfBirth;
  final String position;
  final String phoneNumber;
  final String email;

  MyUserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.urlAvatar,
    required this.phoneNumber,
    this.employeeNumber = 000,
    Timestamp? dateOfBirth,
    this.position = "Developer",
  }) : dateOfBirth = Timestamp.now();

  MyUserEntity copyWith({
    String? uid,
    String? name,
    String? urlAvatar,
    int? employeeNumber,
    Timestamp? dateOfBirth,
    String? position,
    String? phoneNumber,
    String? email,
  }) {
    return MyUserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      urlAvatar: urlAvatar ?? this.urlAvatar,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      position: position ?? this.position,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
