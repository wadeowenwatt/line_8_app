import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreRepository {
  Future<void> updateUserData(
    String uid,
    String? name,
    String? email,
    String employeeNumber,
  );
}

class FirestoreRepositoryImpl extends FirestoreRepository {
  CollectionReference membersCollection =
      FirebaseFirestore.instance.collection("members");

  @override
  Future<void> updateUserData(
    String uid,
    String? name,
    String? email,
    String? employeeNumber,
  ) async {
    return await membersCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'employeeNumber': employeeNumber,
    });
  }
}
