import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/ui/pages/chat/widgets/message_row.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

import '../../../../models/entities/user/my_user_entity.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required this.messages,
    required this.guest,
    required this.currentUser,
  });

  final List<ChatMessageEntity> messages;
  final MyUserEntity guest;
  final MyUserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: messages.length,
      itemBuilder: (_, index) {
        final message = messages[index];
        final nextMessage = index > 0 ? messages[index - 1] : null;
        final prevMessage =
            index + 1 < messages.length ? messages[index + 1] : null;
        final bool isAfterDateSeparator =
            _shouldShowDateSeparator(prevMessage, message);
        bool isBeforeDateSeparator = false;
        if (nextMessage != null) {
          isBeforeDateSeparator =
              _shouldShowDateSeparator(message, nextMessage);
        }
        final isOwnMessage = message.authorId == guest.uid;

        return Column(
          crossAxisAlignment:
              isOwnMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (isAfterDateSeparator)
              Padding(
                padding: EdgeInsets.only(
                    top: isAfterDateSeparator ? 24 : 6,
                    bottom: isBeforeDateSeparator ? 24 : 6),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: AppColors.greyAccent,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        AppDateUtils.toDateTimeString(
                            message.createdAt.toDate(),
                            format: "MM/dd/yyyy"),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackAccent),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: AppColors.greyAccent,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
            MessageRow(
              message: message,
              prevMessage: prevMessage,
              nextMessage: nextMessage,
              currentUser: guest,
            ),
          ],
        );
      },
    );
  }

  bool _shouldShowDateSeparator(
      ChatMessageEntity? previousMessage, ChatMessageEntity message) {
    if (previousMessage == null) {
      return true;
    }
    return previousMessage.createdAt
            .toDate()
            .difference(message.createdAt.toDate())
            .inDays
            .abs() >
        0;
  }
}
