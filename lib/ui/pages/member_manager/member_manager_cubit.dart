import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../blocs/app_cubit.dart';
import '../../../repositories/firestore_repository.dart';

part 'member_manager_state.dart';

class MemberManagerCubit extends Cubit<MemberManagerState> {
  final FirestoreRepository firestoreRepository;
  final AppCubit appCubit;

  MemberManagerCubit({
    required this.appCubit,
    required this.firestoreRepository,
  }) : super(MemberManagerState());

  Future<void> deleteUser() async {
    /// Todo
  }
}
