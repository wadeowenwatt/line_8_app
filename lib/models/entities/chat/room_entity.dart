import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  String? id;
  String? newMessage;
  String? authorNewMess;
  Timestamp? createAt;
  Timestamp? updateAt;
  List<dynamic> listUidParticipants;

  Room({
    this.id,
    this.newMessage,
    this.authorNewMess,
    this.createAt,
    this.updateAt,
    required this.listUidParticipants,
  });

  Room copyWith({
    String? id,
    String? newMessage,
    String? authorNewMess,
    Timestamp? createAt,
    Timestamp? updateAt,
    List<dynamic>? listUidParticipants,
  }) {
    return Room(
      id: id ?? this.id,
      newMessage: newMessage ?? this.newMessage,
      authorNewMess: authorNewMess ?? this.authorNewMess,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      listUidParticipants: listUidParticipants ?? this.listUidParticipants,
    );
  }

  static Room fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      newMessage: json['newMessage'],
      authorNewMess: json['authorNewMess'],
      createAt: json['createAt'],
      updateAt: json['updateAt'],
      listUidParticipants: json['participants'],
    );
  }
}
