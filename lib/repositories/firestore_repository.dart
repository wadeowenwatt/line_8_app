import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/models/entities/event/event_entity.dart';
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

  Future<List<MyUserEntity>> fetchListUserData();

  Future<void> updateDataUser({required MyUserEntity userUpdate});

  Future<void> createEventRequest({
    String? title,
    required DateTime timeStart,
    DateTime? timeStop,
    String? details,
    bool requested,
  });

  Future<List<Event>> fetchEventNotAccepted();

  Future<List<Event>> fetchEventAccepted();

  Future<void> acceptEventRequest(String docId);

  Future<void> rejectEventRequest(String docId);

  Future<void> createReport(String uid, String field1, String field2, String field3);

  Future<void> sendFeedback(String comment, double rate);

}

class FirestoreRepositoryImpl extends FirestoreRepository {
  CollectionReference membersCollection =
  FirebaseFirestore.instance.collection("members");

  CollectionReference eventsCollection =
  FirebaseFirestore.instance.collection("event_requests");

  CollectionReference reportsCollection =
  FirebaseFirestore.instance.collection("weekly_report");

  CollectionReference feedbacksCollection =
  FirebaseFirestore.instance.collection("feedback");

  /// USER REPO
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
  Future<void> updateDataUser({required MyUserEntity userUpdate}) async {
    try {
      membersCollection.doc(userUpdate.uid).update({
        'uid': userUpdate.uid,
        'name': userUpdate.name,
        'email': userUpdate.email,
        'url_avatar': userUpdate.urlAvatar,
        'phone_number': userUpdate.phoneNumber,
        'employee_number': userUpdate.employeeNumber,
        'date_of_birth': userUpdate.dateOfBirth,
        'position': userUpdate.position,
        'department': userUpdate.department,
      });
    } catch (error) {
      print("$error update user failed!");
    }
  }

  @override
  Future<List<MyUserEntity>> fetchListUserData() async {
    List<MyUserEntity> listUser = [];
    try {
      await membersCollection.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          MyUserEntity myUserEntity =
          MyUserEntity.fromJson(doc.data() as Map<String, dynamic>);
          listUser.add(myUserEntity);
        }
      });
    } catch (error) {
      print("$error fetch List user failed!");
    }
    return listUser;
  }

  /// EVENT REPO
  @override
  Future<void> createEventRequest({
    String? title,
    required DateTime timeStart,
    DateTime? timeStop,
    String? details,
    bool requested = false,
  }) async {
    try {
      String id = eventsCollection.doc().id;
      await eventsCollection.doc(id).set({
        'id': id,
        'title': title,
        'time_start': Timestamp.fromDate(timeStart),
        'time_stop': Timestamp.fromDate(timeStop ?? timeStart),
        'details': details,
        'requested': requested,
      }).then((value) => null);
    } catch (e) {
      print("ADD EVENT ERROR: $e");
    }
  }

  @override
  Future<List<Event>> fetchEventNotAccepted() async {
    List<Event> listEvent = [];
    try {
      await eventsCollection.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Event eventEntity =
          Event.fromJson(doc.data() as Map<String, dynamic>);
          if (!eventEntity.requested) {
            listEvent.add(eventEntity);
          }
        }
      });
    } catch (error) {
      print("$error fetch List event failed!");
    }
    return listEvent;
  }

  @override
  Future<List<Event>> fetchEventAccepted() async {
    List<Event> listEvent = [];
    try {
      await eventsCollection.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Event eventEntity = Event.fromJson(
              doc.data() as Map<String, dynamic>);
          if (eventEntity.requested) {
            listEvent.add(eventEntity);
          }
        }
      });
    } catch (error) {
      print("$error fetch List event accepted failed!");
    }
    return listEvent;
  }

  @override
  Future<void> acceptEventRequest(String docId) async {
    try {
      eventsCollection.doc(docId).update({
        'requested' : true,
      });
    } catch(error) {
      print(error);
    }
  }

  @override
  Future<void> rejectEventRequest(String docId) {
    return eventsCollection
        .doc(docId)
        .delete()
        .catchError((error) => print("Failed to reject event: $error"));
  }

  @override
  Future<void> createReport(String uid, String field1, String field2, String field3) async {
    String id = reportsCollection.doc().id;
    await reportsCollection.doc(id).set({
      'uid': uid,
      'have_done': field1,
      'impact_work': field2,
      'will_do': field3,
    });
  }

  @override
  Future<void> sendFeedback(String comment, double rate) async {
    String id = eventsCollection.doc().id;
    await feedbacksCollection.doc(id).set({
      "rate" : rate,
      "comment" : comment,
    });
  }

}
