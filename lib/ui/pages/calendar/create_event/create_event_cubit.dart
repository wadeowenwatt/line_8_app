import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/ui/commons/app_snackbar.dart';
import 'package:get/get.dart';

import '../../../../router/route_config.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  final FirestoreRepository firestoreRepo;

  CreateEventCubit({required this.firestoreRepo})
      : super(const CreateEventState());

  void changeTitle({required String title}) {
    emit(state.copyWith(title: title));
  }

  void changeTimeStart({required DateTime timeStart}) {
    emit(state.copyWith(timeStart: timeStart));
  }

  void changeTimeStop({required DateTime timeStop}) {
    emit(state.copyWith(timeStop: timeStop));
  }

  void changeDetails({required String details}) {
    emit(state.copyWith(details: details));
  }

  Future createEvent() async {
    final title = state.title ?? "";
    final timeStart = state.timeStart;
    final timeStop = state.timeStop;
    final details = state.details ?? "";

    if (title.isEmpty) {
      AppSnackbar.showError(message: "Title is empty");
      return;
    }

    if (timeStart.isNull) {
      AppSnackbar.showError(message: "Time Start is empty");
      return;
    }
    // if (!timeStart.isNull) {
    //   AppSnackbar.showInfo(message: "Time Start: ${state.timeStart}");
    //   return;
    // }

    if (timeStop.isNull) {
      AppSnackbar.showError(message: "Time Stop is empty");
      return;
    }
    // if (!timeStop.isNull) {
    //   AppSnackbar.showInfo(message: "Time Stop: ${state.timeStop}");
    //   return;
    // }

    if (details.isEmpty) {
      AppSnackbar.showError(message: "Details is empty");
      return;
    }
    emit(state.copyWith(createEventStatus: LoadStatus.loading));
    try {
      AppDialog.showLoadingDialog();
      await firestoreRepo.createEventRequest(
        title: title,
        timeStart: timeStart!,
        timeStop: timeStop!,
        details: details,
      );
      emit(state.copyWith(createEventStatus: LoadStatus.success));
      Get.back();
    } catch (error) {
      print(error);
    }
  }
}
