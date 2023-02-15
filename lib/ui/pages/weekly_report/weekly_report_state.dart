part of 'weekly_report_cubit.dart';

class WeeklyReportState extends Equatable {
  final String? field1;
  final String? field2;
  final String? field3;

  const WeeklyReportState({this.field1, this.field2, this.field3});

  WeeklyReportState copyWith({
    String? field1,
    String? field2,
    String? field3,
  }) {
    return WeeklyReportState(
      field1: field1 ?? this.field1,
      field2: field2 ?? this.field2,
      field3: field3 ?? this.field3,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        field1,
        field2,
        field3,
      ];
}
