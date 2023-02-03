import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_rooms_chat_state.dart';

class MyRoomsChatCubit extends Cubit<MyRoomsChatState> {
  MyRoomsChatCubit() : super(MyRoomsChatInitial());
}
