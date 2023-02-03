import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/ui/pages/chat/widgets/chat_header.dart';
import 'package:flutter_base/ui/pages/chat/widgets/chat_input.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message_list.dart';

import '../../../../models/entities/user/my_user_entity.dart';

class ChatUI extends StatelessWidget {
  const ChatUI(
      {super.key,
      required this.onSend,
      required this.userChatWith,
      required this.messages,
      required this.currentUser});

  final Function(ChatMessageEntity) onSend;
  final MyUserEntity userChatWith;
  final MyUserEntity currentUser;
  final List<ChatMessageEntity> messages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      body: Column(
        children: [
          ChatHeader(
            guest: userChatWith,
          ),
          Expanded(
            child: MessageList(
              guest: userChatWith,
              messages: messages,
              currentUser: currentUser,
            ),
          ),
          ChatInput(
            onSend: onSend,
            currentUser: userChatWith,
          ),
        ],
      ),
    );
  }
}
