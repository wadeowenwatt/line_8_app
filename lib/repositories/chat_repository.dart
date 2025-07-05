import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/room_entity.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:get/get.dart';

import '../router/route_config.dart';
import '../utils/logger.dart';

abstract class ChatRepository {
  Future<List<ChatMessageEntity>> getMessagesByRoomId(String roomId);

  Future<ChatMessageEntity> sendMessage(ChatMessageEntity message);

  Future<List<Room>> fetchListRoomHasMe(String uid);

  Future<void> createRoomChat(String currentUid, String guestUid);

  Future<void> updateNewMessage(String roomId, String newMessage, String uid);

}

class ChatRepositoryImpl extends ChatRepository {
  CollectionReference members =
      FirebaseFirestore.instance.collection('members');
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

  @override
  Future<List<Room>> fetchListRoomHasMe(String uid) async {
    List<Room> listRoomHasMe = [];
    try {
      await rooms.get().then((QuerySnapshot querySnapShot) {
        for (var doc in querySnapShot.docs) {
          Room temp = Room.fromJson(doc.data() as Map<String, dynamic>);
          for (var id in temp.listUidParticipants) {
            if (id == uid) {
              listRoomHasMe.add(temp);
            }
          }
        }
      });
    } catch (error) {}
    return listRoomHasMe;
  }

  @override
  Future<void> createRoomChat(String currentUid, String guestUid) async {
    try {
      bool isExist = false;

      MyUserEntity currentUser =
      await members.doc(currentUid).get().then((value) {
        return MyUserEntity.fromJson(value.data() as Map<String, dynamic>);
      });

      MyUserEntity guestUser = await members.doc(guestUid).get().then((value) {
        return MyUserEntity.fromJson(value.data() as Map<String, dynamic>);
      });

      await rooms.get().then(
        (snapShot) {
          for (var doc in snapShot.docs) {
            final room = Room.fromJson(doc.data() as Map<String, dynamic>);
            if (room.listUidParticipants.contains(currentUid) &&
                room.listUidParticipants.contains(guestUid)) {
              isExist = true;
              Get.offNamed(RouteConfig.chat, arguments: [room.id, currentUser, guestUser]);
              return;
            }
          }
        },
      );

      if (!isExist) {
        String id = rooms
            .doc()
            .id;
        await rooms.doc(id).set({
          'id': id,
          'newMessage': "Say hello to your friend 👋",
          'participants': [currentUid, guestUid],
          'createAt': Timestamp.fromDate(DateTime.now()),
          'updateAt': Timestamp.fromDate(DateTime.now()),
        });
        Get.offNamed(RouteConfig.chat, arguments: [id, currentUser, guestUser]);
      }
    } catch (error) {
      logger.e(error);
    }
  }

  @override
  Future<void> updateNewMessage(String roomId, String newMessage, String uid) async {
    try {
      rooms.doc(roomId).update({
        'newMessage': newMessage,
        'authorNewMess': uid,
      });
    } catch(error) {
      logger.e(error);
    }
  }
}
