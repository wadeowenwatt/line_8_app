import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/chat_repository.dart';
import 'package:flutter_base/utils/app_stream.dart';
import 'package:flutter_base/utils/logger.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;

  ChatCubit({required this.chatRepository}) : super(const ChatState());

  Future<void> fetchInitData() async {
    emit(
      state.copyWith(fetchDataStatus: LoadStatus.loading),
    );
    try {
      final result =
          await chatRepository.getMessagesByRoomId("LB92pLVDUomWoHsHxpCw");
      emit(
        state.copyWith(fetchDataStatus: LoadStatus.success, messages: result),
      );
    } catch (e) {
      logger.e(e.toString());
      emit(
        state.copyWith(fetchDataStatus: LoadStatus.loading),
      );
    }

    AppStream.messageChanged.stream.listen((event) async {
      final result =
          await chatRepository.getMessagesByRoomId("LB92pLVDUomWoHsHxpCw");
      emit(
        state.copyWith(fetchDataStatus: LoadStatus.success, messages: result),
      );
    });
  }

  Future<void> onSend(ChatMessageEntity newMessage) async {
    newMessage.roomId = "LB92pLVDUomWoHsHxpCw";
    final result = await chatRepository.sendMessage(newMessage);
    newMessage.messageId = state.messages.length.toString();
    emit(
      state.copyWith(
        messages: <ChatMessageEntity>[
          ...state.messages,
          result,
        ],
      ),
    );
  }
}
