import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'member_manager_state.dart';

class MemberManagerCubit extends Cubit<MemberManagerState> {
  MemberManagerCubit() : super(MemberManagerInitial());
}
