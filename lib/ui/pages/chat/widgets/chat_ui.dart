import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/ui/pages/chat/widgets/chat_header.dart';
import 'package:flutter_base/ui/pages/chat/widgets/chat_input.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message_list.dart';

class ChatUI extends StatelessWidget {
  const ChatUI(
      {super.key,
      required this.onSend,
      required this.currentUser,
      required this.messages});

  final Function(ChatMessageEntity) onSend;
  final ChatUserEntity currentUser;
  final List<ChatMessageEntity> messages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      body: Column(
        children: [
          ChatHeader(
            currentUser: currentUser,
          ),
          Expanded(
            child: MessageList(currentUser: currentUser, messages: messages),
          ),
          ChatInput(
            onSend: onSend,
            currentUser: currentUser,
          ),
        ],
      ),
    );
  }
}
