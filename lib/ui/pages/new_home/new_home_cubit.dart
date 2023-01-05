import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_home_state.dart';

class NewHomeCubit extends Cubit<NewHomeState> {
  NewHomeCubit() : super(NewHomeInitial());
}
