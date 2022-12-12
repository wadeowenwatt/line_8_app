import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppStream {
  static StreamController messageChanged = StreamController.broadcast();
  static StreamController userChanged = StreamController.broadcast();
  static StreamController roomChanged = StreamController.broadcast();

  static void setup() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      userChanged.sink.add(true);
    });

    FirebaseFirestore.instance
        .collection('messages')
        .snapshots()
        .listen((event) {
      messageChanged.sink.add(true);
    });

    FirebaseFirestore.instance.collection('rooms').snapshots().listen((event) {
      roomChanged.sink.add(true);
    });
  }
}
