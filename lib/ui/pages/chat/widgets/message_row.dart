import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/models/enums/message_type.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message/audio_message.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message/file_message.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message/image_message.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message/text_message.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message/video_message.dart';
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
      child: _buildMessage(message),
    );
  }

  Widget _buildMessage(ChatMessageEntity message) {
    if (message.type == MessageType.text) {
      return TextMessage(
        message: message,
        currentUser: currentUser,
      );
    } else if (message.type == MessageType.audio) {
      return AudioMessage(
        message: message,
        currentUser: currentUser,
      );
    } else if (message.type == MessageType.image) {
      return ImageMessage(
        message: message,
        currentUser: currentUser,
      );
    } else if (message.type == MessageType.video) {
      return VideoMessage(
        message: message,
        currentUser: currentUser,
      );
    } else if (message.type == MessageType.file) {
      return FileMessage(
        message: message,
        currentUser: currentUser,
      );
    } else {
      return TextMessage(message: message, currentUser: currentUser);
    }
  }
}
