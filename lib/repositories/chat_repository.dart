import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';

abstract class ChatRepository {
  Future<List<ChatMessageEntity>> getMessagesByRoomId(String roomId);

  Future<ChatMessageEntity> sendMessage(ChatMessageEntity message);
}

class ChatRepositoryImpl extends ChatRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

  @override
  Future<List<ChatMessageEntity>> getMessagesByRoomId(String roomId) async {
    final messagesColl = await messages
        .orderBy("createdAt")
        .where("roomId", isEqualTo: roomId)
        .get();
    List<ChatMessageEntity> messagesList = [];
    for (var messageSnapshot in messagesColl.docs) {
      final ChatMessageEntity messageEntity = ChatMessageEntity.fromJson(
              messageSnapshot.data() as Map<String, dynamic>)
          .copyWith(messageId: messageSnapshot.id);
      messagesList.add(messageEntity);
    }
    return messagesList;
  }

  @override
  Future<ChatMessageEntity> sendMessage(ChatMessageEntity message) async {
    final messageId = (await messages.add(message.toJsonWithoutMessageId())).id;
    return message.copyWith(messageId: messageId);
  }
}
