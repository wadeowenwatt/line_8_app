import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/calendar/calendar_page.dart';

import '../../../blocs/app_cubit.dart';
import '../../../models/entities/event/event_entity.dart';
import '../../../repositories/firestore_repository.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final FirestoreRepository firestoreRepo;
  final AppCubit appCubit;

  CalendarCubit({required this.firestoreRepo, required this.appCubit}) : super(CalendarState());

  void convertListEventToEventByDay(
      LinkedHashMap<DateTime, List<Event>> events) async {
    await getEvent();
    if (state.listEventAccepted!.isNotEmpty) {
      for (var event in state.listEventAccepted!) {
        events[event.timeStart!.toDate()]?.add(event);
      }
    }
    emit(state.copyWith(events: events, getEventStatus: LoadStatus.success));
  }

  Future getEvent() async {
    emit(state.copyWith(getEventStatus: LoadStatus.loading));
    try {
      List<Event> listEventAccepted = [];
      listEventAccepted = await firestoreRepo.fetchEventAccepted();

      Map<DateTime, List<Event>> all = {};
      for (var event in listEventAccepted) {
        if (all[event.timeStart?.toDate() as DateTime] == null) {
          all[event.timeStart?.toDate() as DateTime] = [];
          all[event.timeStart?.toDate() as DateTime]?.add(event);
        } else {
          all[event.timeStart?.toDate() as DateTime]?.add(event);
        }
        // logger.d(event.toString());
      }
      CalendarPage.events.addAll(all);
      emit(state.copyWith(getEventStatus: LoadStatus.success));
    } catch (error) {
      emit(state.copyWith(getEventStatus: LoadStatus.failure));
    }
  }
}
