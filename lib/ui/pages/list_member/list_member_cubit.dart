import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../blocs/app_cubit.dart';
import '../../../repositories/firestore_repository.dart';

part 'list_member_state.dart';

class ListMemberCubit extends Cubit<ListMemberState> {
  final FirestoreRepository firestoreRepository;
  final AppCubit appCubit;

  ListMemberCubit({
    required this.firestoreRepository,
    required this.appCubit,
  }) : super(ListMemberInitial());


  Future<void> fetchUserFromUId(String uid) async {
    /// Todo
  }

}
