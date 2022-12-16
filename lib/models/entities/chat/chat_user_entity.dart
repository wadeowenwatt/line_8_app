import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUserEntity {
  final String chatUserId;
  final String avatarUrl;
  final String firstName;
  final String lastName;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final int status;
  final String phone;
  final String phoneCode;

  ChatUserEntity(
      {this.chatUserId = "",
      this.avatarUrl = "",
      required this.firstName,
      this.lastName = "",
      Timestamp? createdAt,
      Timestamp? updatedAt,
      this.phoneCode = "84",
      this.phone = "1234567890",
      this.status = 0})
      : createdAt = Timestamp.now(),
        updatedAt = Timestamp.now();

  ChatUserEntity copyWith({
    String? chatUserId,
    String? avatarUrl,
    String? firstName,
    String? lastName,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    int? status,
    String? phone,
    String? phoneCode,
  }) {
    return ChatUserEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      chatUserId: chatUserId ?? this.chatUserId,
      phone: phone ?? this.phone,
      phoneCode: phoneCode ?? this.phoneCode,
    );
  }
}
