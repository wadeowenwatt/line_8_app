part of 'feedback_cubit.dart';

class FeedbackState extends Equatable {
  final String? comment;
  final double? rate;

  const FeedbackState({
    this.comment,
    this.rate,
  });

  FeedbackState copyWith({
    String? comment,
    double? rate,
  }) {
    return FeedbackState(
      comment: comment ?? this.comment,
      rate: rate ?? this.rate,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    comment,
    rate,
  ];
}
