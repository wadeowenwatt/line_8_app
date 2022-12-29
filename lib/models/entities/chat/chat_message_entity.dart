import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_base/models/enums/message_type.dart';

class ChatMessageEntity {
  String messageId;
  String roomId;
  final String authorId;
  final Map<String, dynamic>? meta;
  final MessageType type;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final String text;

  ChatMessageEntity({
    this.roomId = "",
    this.messageId = "",
    required this.authorId,
    this.meta,
    required this.type,
    this.text = "",
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  ChatMessageEntity copyWith({
    String? roomId,
    String? messageId,
    String? authorId,
    Map<String, dynamic>? meta,
    MessageType? type,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    String? text,
  }) {
    return ChatMessageEntity(
      roomId: roomId ?? this.roomId,
      text: text ?? this.text,
      messageId: messageId ?? this.messageId,
      authorId: authorId ?? this.authorId,
      meta: meta ?? this.meta,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'authorId': authorId,
      'createdAt': createdAt,
      'roomId': roomId,
      'text': text,
      'type': EnumToString.convertToString(type),
      'updatedAt': updatedAt,
      'meta': meta
    };
  }

  Map<String, dynamic> toJsonWithoutMessageId() {
    return {
      'authorId': authorId,
      'createdAt': createdAt,
      'roomId': roomId,
      'text': text,
      'type': EnumToString.convertToString(type),
      'updatedAt': updatedAt,
      'meta': meta
    };
  }

  static ChatMessageEntity fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      authorId: json["authorId"],
      createdAt: json["createdAt"],
      roomId: json["roomId"],
      updatedAt: json["updatedAt"],
      text: json["text"],
      type: EnumToString.fromString(MessageType.values, json["type"]) ??
          MessageType.text,
      meta: json["meta"],
    );
  }
}
