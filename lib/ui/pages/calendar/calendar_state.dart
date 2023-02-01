part of 'calendar_cubit.dart';

class CalendarState extends Equatable {
  LoadStatus? getEventStatus;
  LinkedHashMap<DateTime, List<Event>>? events;
  List<Event>? listEventAccepted;

  CalendarState({
    this.getEventStatus = LoadStatus.initial,
    this.listEventAccepted,
    this.events,
  });

  CalendarState copyWith({
    LoadStatus? getEventStatus,
    LinkedHashMap<DateTime, List<Event>>? events,
    List<Event>? listEventAccepted,
  }) {
    return CalendarState(
      getEventStatus: getEventStatus ?? this.getEventStatus,
      events: events ?? this.events,
      listEventAccepted: listEventAccepted ?? this.listEventAccepted,
    );
  }

  @override
  List<Object?> get props => [
        getEventStatus,
        events,
        listEventAccepted,
      ];
}
