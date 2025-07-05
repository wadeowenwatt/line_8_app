import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../blocs/app_cubit.dart';
import '../../../../repositories/chat_repository.dart';

part 'list_member_chat_state.dart';

class ListMemberChatCubit extends Cubit<ListMemberChatState> {
  ListMemberChatCubit({
    required this.chatRepo,
    required this.appCubit,
  }) : super(ListMemberChatInitial());

  final ChatRepository chatRepo;
  final AppCubit appCubit;
}
