part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState(
      {this.messages = const [], this.fetchDataStatus = LoadStatus.initial});

  final List<ChatMessageEntity> messages;
  final LoadStatus fetchDataStatus;

  @override
  List<Object> get props => [messages, fetchDataStatus];

  ChatState copyWith(
      {List<ChatMessageEntity>? messages, LoadStatus? fetchDataStatus}) {
    return ChatState(
        messages: messages ?? this.messages,
        fetchDataStatus: fetchDataStatus ?? this.fetchDataStatus);
  }
}
