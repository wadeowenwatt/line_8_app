import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';

abstract class FirestoreRepository {
  Future<void> createUserData({
    required String uid,
    String? name,
    String? email,
    String? urlAvatar,
    String? phoneNumber,
    String? employeeNumber,
    DateTime? dateOfBirth,
    String? position,
    String? department,
  });

  Future<MyUserEntity?> fetchUserData(String uid);

  Future<void> updateDataUser({
    required String uid,
    String? name,
    String? email,
    String? urlAvatar,
    String? phoneNumber,
    String? employeeNumber,
    DateTime? dateOfBirth,
    String? position,
    String? department,
  });
}

class FirestoreRepositoryImpl extends FirestoreRepository {
  CollectionReference membersCollection =
      FirebaseFirestore.instance.collection("members");

  @override
  Future<void> createUserData({
    required String uid,
    String? name,
    String? email,
    String? urlAvatar,
    String? phoneNumber,
    String? employeeNumber,
    DateTime? dateOfBirth,
    String? position,
    String? department,
  }) async {
    return await membersCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'url_avatar': urlAvatar,
      'phone_number': phoneNumber,
      'employee_number': employeeNumber,
      'date_of_birth': dateOfBirth != null
          ? Timestamp.fromDate(dateOfBirth)
          : Timestamp.fromDate(DateTime(1900)),
      'position': position ?? "Developer",
      'department': department ?? "Line 8",
    });
  }

  @override
  Future<MyUserEntity?> fetchUserData(String uid) async {
    MyUserEntity? myUserEntity;
    try {
      await membersCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
        myUserEntity =
            MyUserEntity.fromJson(snapshot.data() as Map<String, dynamic>);
      });
    } catch (error) {
      print('$error fetch user data failed');
    }
    return myUserEntity;
  }

  @override
  Future<void> updateDataUser(
      {required String uid,
      String? name,
      String? email,
      String? urlAvatar,
      String? phoneNumber,
      String? employeeNumber,
      DateTime? dateOfBirth,
      String? position,
      String? department}) async {
    try {
      membersCollection.doc(uid).update({
        'uid': uid,
        'name': name,
        'email': email,
        'url_avatar': urlAvatar,
        'phone_number': phoneNumber,
        'employee_number': employeeNumber,
        'date_of_birth': Timestamp.fromDate(dateOfBirth!),
        'position': position,
        'department': department,
      });
    } catch (error) {
      print("$error update user failed!");
    }
  }
}
