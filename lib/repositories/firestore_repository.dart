import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';

abstract class FirestoreRepository {
  Future<void> createUserData(
    String uid,
    String? name,
    String? email,
    String? urlAvatar, [
    String? phoneNumber,
    int? employeeNumber,
    DateTime? dateOfBirth,
    String? position,
  ]);

  Future<MyUserEntity?> fetchUserData(String uid);
}

class FirestoreRepositoryImpl extends FirestoreRepository {
  CollectionReference membersCollection =
      FirebaseFirestore.instance.collection("members");

  @override
  Future<void> createUserData(
    String uid,
    String? name,
    String? email,
    String? urlAvatar, [
    String? phoneNumber,
    int? employeeNumber,
    DateTime? dateOfBirth,
    String? position,
  ]) async {
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
    });
  }

  @override
  Future<MyUserEntity?> fetchUserData(String uid) async {
    MyUserEntity? myUserEntity;
    try {
      await membersCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
        myUserEntity = MyUserEntity.fromJson(snapshot.data() as Map<String, dynamic>);
      });
    } catch(error) {
      print('$error fetch user data failed');
    }
    return myUserEntity;
  }
}
