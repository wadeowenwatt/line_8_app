import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/repositories/chat_repository.dart';
import 'package:flutter_base/ui/pages/chat/chat_cubit.dart';
import 'package:flutter_base/ui/pages/chat/widgets/chat_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        chatRepository: RepositoryProvider.of<ChatRepository>(context),
      ),
      child: const ChatChildPage(),
    );
  }
}

class ChatChildPage extends StatefulWidget {
  const ChatChildPage({super.key});

  @override
  State<ChatChildPage> createState() => _ChatChildPageState();
}

class _ChatChildPageState extends State<ChatChildPage> {
  late final ChatCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<ChatCubit>();
    _cubit.fetchInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChatCubit, ChatState>(
          bloc: _cubit,
          builder: (context, state) {
            return ChatUI(
              messages: List.from(state.messages.reversed),
              onSend: _cubit.onSend,
              currentUser: ChatUserEntity(
                chatUserId: "123",
                firstName: "User 1",
              ),
            );
          },
        ),
      ),
    );
  }
}
