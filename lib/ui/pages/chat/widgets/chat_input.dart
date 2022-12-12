import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/models/enums/message_type.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInput extends StatelessWidget {
  final Function(ChatMessageEntity) onSend;
  final ChatUserEntity currentUser;

  ChatInput({super.key, required this.onSend, required this.currentUser});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minHeight: 72, maxHeight: size.height * 0.12),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 12,
      ),
      child: SizedBox(
        height: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxHeight: 72),
              padding: const EdgeInsets.only(right: 12),
              child: SvgPicture.asset(
                AppImages.icAdd,
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: _controller,
                onFieldSubmitted: _onSend,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackAccent,
                ),
                maxLines: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE3E3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  prefixIcon: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset(
                      AppImages.icSmile,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  suffixIcon: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset(
                      AppImages.icSend,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(
                      left: 4, right: 4, top: 4, bottom: 4),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 16,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSend(String text) {
    if (text.isNotEmpty) {
      final ChatMessageEntity message = ChatMessageEntity(
        authorId: currentUser.chatUserId,
        text: text,
        type: MessageType.text,
      );
      onSend(message);
      _controller.text = "";
    }
  }
}
