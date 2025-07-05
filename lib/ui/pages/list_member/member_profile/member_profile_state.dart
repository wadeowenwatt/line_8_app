part of 'member_profile_cubit.dart';

class MemberProfileState extends Equatable {
  final LoadStatus fetchProfileStatus;
  final MyUserEntity? user;

  const MemberProfileState({
    this.fetchProfileStatus = LoadStatus.initial,
    this.user,
  });

  MemberProfileState copyWith({
    LoadStatus? fetchProfileStatus,
    MyUserEntity? user,
  }) {
    return MemberProfileState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props =>
      [
        fetchProfileStatus,
        user,
      ];
}
