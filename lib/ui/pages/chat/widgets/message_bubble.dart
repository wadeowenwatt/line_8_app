import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

import '../../../../models/entities/user/my_user_entity.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.child,
      required this.currentUser,
      required this.message,
      this.prevMessage,
      this.nextMessage})
      : super(key: key);
  final Widget child;
  final MyUserEntity currentUser;
  final ChatMessageEntity message;
  final ChatMessageEntity? prevMessage;
  final ChatMessageEntity? nextMessage;

  @override
  Widget build(BuildContext context) {
    final isOwnMessage = message.authorId == currentUser.uid;
    final isGroup = message.authorId == nextMessage?.authorId;
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: isGroup ? 5 : 10, right: 8, left: 8),
          child: Column(
            crossAxisAlignment: isOwnMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width * 0.7),
                child: child,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, top: 5),
                child: Text(
                  AppDateUtils.toDateTimeString(message.createdAt.toDate(),
                      format: "hh:mm a"),
                  style: const TextStyle(
                      fontSize: 10,
                      height: 15 / 10,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
