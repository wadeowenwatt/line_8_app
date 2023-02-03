import 'package:cloud_firestore/cloud_firestore.dart';

class MyUserEntity {
  String uid;
  String? name;
  String? urlAvatar;
  String? employeeNumber;
  Timestamp? dateOfBirth;
  String? position;
  String? phoneNumber;
  String? email;
  String? department;
  int? status;

  MyUserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.urlAvatar,
    required this.phoneNumber,
    this.employeeNumber = "000",
    this.dateOfBirth,
    this.position = "Developer",
    this.department = "Line 8",
    this.status = 1,
  });

  MyUserEntity copyWith({
    String? uid,
    String? name,
    String? urlAvatar,
    String? employeeNumber,
    Timestamp? dateOfBirth,
    String? position,
    String? phoneNumber,
    String? email,
    String? department,
    int? status,
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
      department: department ?? this.department,
      status: status ?? this.status,
    );
  }

  static MyUserEntity fromJson(Map<String, dynamic> json) {
    return MyUserEntity(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      urlAvatar: json["url_avatar"],
      phoneNumber: json["phone_number"],
      dateOfBirth: json["date_of_birth"],
      employeeNumber: json["employee_number"],
      position: json["position"],
      department: json["department"],
      status: json["status"],
    );
  }
}
