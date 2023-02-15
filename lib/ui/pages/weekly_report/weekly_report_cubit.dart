import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../blocs/app_cubit.dart';
import '../../../repositories/firestore_repository.dart';
import '../../../utils/logger.dart';
import '../../commons/app_dialog.dart';
import '../../commons/app_snackbar.dart';

part 'weekly_report_state.dart';

class WeeklyReportCubit extends Cubit<WeeklyReportState> {
  final FirestoreRepository firestoreRepo;
  final AppCubit appCubit;

  WeeklyReportCubit({required this.firestoreRepo, required this.appCubit})
      : super(const WeeklyReportState());

  void changeField1({required String field1}) {
    emit(state.copyWith(field1: field1));
  }
  void changeField2({required String field2}) {
    emit(state.copyWith(field2: field2));
  }
  void changeField3({required String field3}) {
    emit(state.copyWith(field3: field3));
  }

  void createReport() async {
    final field1 = state.field1 ?? "";
    final field2 = state.field2 ?? "";
    final field3 = state.field3 ?? "";
    try {
      AppDialog.showLoadingDialog();
      await firestoreRepo.createReport(appCubit.state.user!.uid, field1, field2, field3);
      Get.back();
      Get.back();
      AppSnackbar.showInfo(title: "Report Weekly", message: "Report completed!");
    } catch (error) {
      logger.e(error);
    }
  }
}
