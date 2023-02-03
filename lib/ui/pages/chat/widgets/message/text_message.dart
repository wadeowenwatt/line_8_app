import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';

import '../../../../../models/entities/user/my_user_entity.dart';

class TextMessage extends StatelessWidget {
  final ChatMessageEntity message;
  final MyUserEntity currentUser;

  const TextMessage(
      {Key? key, required this.message, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOwnMessage = message.authorId == currentUser.uid;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: isOwnMessage ? AppColors.orangeAccent : AppColors.greyAccent,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(8),
          topRight: const Radius.circular(8),
          bottomLeft: isOwnMessage ? const Radius.circular(8) : Radius.zero,
          bottomRight: isOwnMessage ? Radius.zero : const Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        message.text,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color:
                isOwnMessage ? AppColors.whiteAccent : AppColors.blackAccent),
      ),
    );
  }
}
