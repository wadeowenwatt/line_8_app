import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:meta/meta.dart';

import '../../../models/entities/event/event_entity.dart';
import '../../../repositories/firestore_repository.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final FirestoreRepository firestoreRepo;

  CalendarCubit({required this.firestoreRepo}) : super(CalendarState());

  void convertListEventToEventByDay(
      LinkedHashMap<DateTime, List<Event>> events) async {
    await getEvent();
    if (state.listEventAccepted!.isNotEmpty) {
      for (var event in state.listEventAccepted!) {
        events[event.timeStart?.toDate()]?.add(Event(
          id: event.id,
          title: event.title,
          timeStart: event.timeStart,
          timeStop: event.timeStop,
          details: event.details,
          requested: event.requested,
        ));
      }
    }
    emit(state.copyWith(events: events, getEventStatus: LoadStatus.success));
  }

  Future getEvent() async {
    emit(state.copyWith(getEventStatus: LoadStatus.loading));
    try {
      List<Event> listEventAccepted = [];
      /// Need change to accepted
      listEventAccepted = await firestoreRepo.fetchEventNotAccepted();
      emit(state.copyWith(
        listEventAccepted: listEventAccepted));
    } catch (error) {
      emit(state.copyWith(getEventStatus: LoadStatus.failure));
    }
  }
}
