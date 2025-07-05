import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? title;
  Timestamp? timeStart;
  Timestamp? timeStop;
  String? details;
  bool requested;

  Event({
    required this.id,
    required this.title,
    required this.timeStart,
    required this.timeStop,
    required this.details,
    required this.requested,
  });

  Event copyWith({
    String? id,
    String? title,
    Timestamp? timeStart,
    Timestamp? timeStop,
    String? details,
    bool? requested,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      timeStart: timeStart ?? this.timeStart,
      timeStop: timeStop ?? this.timeStop,
      details: details ?? this.details,
      requested: requested ?? this.requested,
    );
  }

  static Event fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      timeStart: json['time_start'],
      timeStop: json['time_stop'],
      details: json['details'],
      requested: json['requested'],
    );
  }
}
