import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

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
  final ChatUserEntity currentUser;
  final ChatMessageEntity message;
  final ChatMessageEntity? prevMessage;
  final ChatMessageEntity? nextMessage;

  @override
  Widget build(BuildContext context) {
    final isOwnMessage = message.authorId == currentUser.chatUserId;
    final isGroup = message.authorId == nextMessage?.authorId;
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: isGroup ? 8 : 16, right: 8, left: 8),
          child: Column(
            crossAxisAlignment: isOwnMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isOwnMessage
                      ? AppColors.orangeAccent
                      : AppColors.greyAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(8),
                    topRight: const Radius.circular(8),
                    bottomLeft:
                        isOwnMessage ? Radius.zero : const Radius.circular(8),
                    bottomRight:
                        isOwnMessage ? const Radius.circular(8) : Radius.zero,
                  ),
                ),
                constraints: BoxConstraints(maxWidth: size.width * 0.7),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: child,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, top: 10),
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
