part of 'create_event_cubit.dart';

class CreateEventState extends Equatable {
  final LoadStatus createEventStatus;
  final String? title;
  final DateTime? timeStart;
  final DateTime? timeStop;
  final String? details;

  const CreateEventState({
    this.createEventStatus = LoadStatus.initial,
    this.title,
    this.timeStart,
    this.timeStop,
    this.details,
  });

  CreateEventState copyWith({
    LoadStatus? createEventStatus,
    String? title,
    DateTime? timeStart,
    DateTime? timeStop,
    String? details,
  }) {
    return CreateEventState(
      createEventStatus: createEventStatus ?? this.createEventStatus,
      title: title ?? this.title,
      timeStart: timeStart ?? this.timeStart,
      timeStop: timeStop ?? this.timeStop,
      details: details ?? this.details,
    );
  }

  @override
  List<Object?> get props => [
        createEventStatus,
        title,
        timeStop,
        timeStart,
        details,
      ];
}
