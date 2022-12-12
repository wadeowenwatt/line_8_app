import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message_bubble.dart';

class MessageRow extends StatelessWidget {
  const MessageRow(
      {super.key,
      required this.message,
      this.prevMessage,
      this.nextMessage,
      required this.currentUser});

  final ChatUserEntity currentUser;
  final ChatMessageEntity message;
  final ChatMessageEntity? prevMessage;
  final ChatMessageEntity? nextMessage;

  @override
  Widget build(BuildContext context) {
    return MessageBubble(
        currentUser: currentUser,
        message: message,
        prevMessage: prevMessage,
        nextMessage: nextMessage,
        child: Text(
          message.text,
        ));
  }
}
