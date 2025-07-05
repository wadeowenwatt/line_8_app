import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../blocs/app_cubit.dart';
import '../../../repositories/firestore_repository.dart';
import '../../commons/app_dialog.dart';
import '../../commons/app_snackbar.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final FirestoreRepository firestoreRepo;
  final AppCubit appCubit;

  FeedbackCubit({required this.firestoreRepo, required this.appCubit}) : super(const FeedbackState());

  void changeComment(String comment) {
    emit(state.copyWith(comment: comment));
  }

  void changeRate(double rate) {
    emit(state.copyWith(rate: rate));
  }

  void sendFeedback() async {
    final comment = state.comment ?? "";
    final rate = state.rate ?? 3;

    try {
      AppDialog.showLoadingDialog();
      await firestoreRepo.sendFeedback(
        comment, rate,
      );
      Get.back();
      Get.back();
      AppSnackbar.showInfo(title: "Feedback", message: "Thank you for your feedback :D!");
    } catch (error) {
      print(error);
    }

  }
}
