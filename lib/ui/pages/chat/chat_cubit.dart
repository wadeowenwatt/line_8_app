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

  Future<void> fetchInitData(String roomId) async {
    emit(
      state.copyWith(fetchDataStatus: LoadStatus.loading),
    );
    try {
      final result =
          await chatRepository.getMessagesByRoomId(roomId);
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
          await chatRepository.getMessagesByRoomId(roomId);
      emit(
        state.copyWith(fetchDataStatus: LoadStatus.success, messages: result),
      );
    });
  }

  Future<void> onSend(ChatMessageEntity newMessage, String roomId) async {
    try {
      newMessage.roomId = roomId;
      await chatRepository.sendMessage(newMessage);
      final result =
          await chatRepository.getMessagesByRoomId(roomId);
      emit(
        state.copyWith(fetchDataStatus: LoadStatus.success, messages: result),
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
