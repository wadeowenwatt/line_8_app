import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  String? id;
  Timestamp? createAt;
  Timestamp? updateAt;
  List<dynamic> listUidParticipants;

  Room({
    this.id,
    this.createAt,
    this.updateAt,
    required this.listUidParticipants,
  });

  Room copyWith({
    String? id,
    Timestamp? createAt,
    Timestamp? updateAt,
    List<dynamic>? listUidParticipants,
  }) {
    return Room(
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      listUidParticipants: listUidParticipants ?? this.listUidParticipants,
    );
  }

  static Room fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      createAt: json['createAt'],
      updateAt: json['updateAt'],
      listUidParticipants: json['participants'],
    );
  }
}
