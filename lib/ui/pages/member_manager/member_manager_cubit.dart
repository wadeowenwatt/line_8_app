import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../blocs/app_cubit.dart';
import '../../../repositories/firestore_repository.dart';

part 'member_manager_state.dart';

class MemberManagerCubit extends Cubit<MemberManagerState> {
  final FirestoreRepository firestoreRepository;
  // final AppCubit appCubit;

  MemberManagerCubit({
    required this.firestoreRepository,
  }) : super(MemberManagerInitial());

  Future<void> deleteUser() async {
    /// Todo
  }
}
