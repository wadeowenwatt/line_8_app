import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppStream {
  static StreamController messageChanged = StreamController.broadcast();
  static StreamController memberChanged = StreamController.broadcast();
  static StreamController roomChanged = StreamController.broadcast();
  static StreamController eventRequestChanged = StreamController.broadcast();
  static StreamController eventChanged = StreamController.broadcast();

  static void setup() {
    FirebaseFirestore.instance.collection('members').snapshots().listen((event) {
      memberChanged.sink.add(true);
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

    FirebaseFirestore.instance.collection('event_requests').snapshots().listen((event) {
      eventRequestChanged.sink.add(true);
    });
    
    FirebaseFirestore.instance.collection('event_requests').snapshots(includeMetadataChanges: true).listen((event) {
      eventChanged.sink.add(true);
    });
  }
}
