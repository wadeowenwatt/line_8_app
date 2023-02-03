import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';
import 'package:flutter_base/repositories/chat_repository.dart';
import 'package:flutter_base/ui/pages/chat/chat_cubit.dart';
import 'package:flutter_base/ui/pages/chat/widgets/chat_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final String roomId = Get.arguments[0];
  final MyUserEntity currentUser = Get.arguments[1];
  final MyUserEntity guestUser = Get.arguments[2];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        chatRepository: RepositoryProvider.of<ChatRepository>(context),
      ),
      child: ChatChildPage(
        roomId: roomId,
        currentUser: currentUser,
        guestUser: guestUser,
      ),
    );
  }
}

class ChatChildPage extends StatefulWidget {
  const ChatChildPage({
    super.key,
    required this.roomId,
    required this.currentUser,
    required this.guestUser,
  });

  final String roomId;
  final MyUserEntity currentUser;
  final MyUserEntity guestUser;

  @override
  State<ChatChildPage> createState() => _ChatChildPageState();
}

class _ChatChildPageState extends State<ChatChildPage> {
  late final ChatCubit _chatCubit;

  @override
  void initState() {
    _chatCubit = BlocProvider.of<ChatCubit>(context);
    _chatCubit.fetchInitData(widget.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChatCubit, ChatState>(
          bloc: _chatCubit,
          builder: (context, state) {
            return ChatUI(
              messages: List.from(state.messages.reversed),
              onSend: (newMessage) => _chatCubit.onSend(
                newMessage,
                widget.roomId,
              ),
              userChatWith: widget.guestUser,
              currentUser: widget.currentUser,
            );
          },
        ),
      ),
    );
  }
}
