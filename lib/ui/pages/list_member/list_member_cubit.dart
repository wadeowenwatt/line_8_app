import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../repositories/firestore_repository.dart';

part 'list_member_state.dart';

class ListMemberCubit extends Cubit<ListMemberState> {
  final FirestoreRepository firestoreRepository;

  ListMemberCubit({
    required this.firestoreRepository,
  }) : super(ListMemberInitial());


  Future<void> fetchUserFromUId(String uid) async {
    /// Todo
  }

}
