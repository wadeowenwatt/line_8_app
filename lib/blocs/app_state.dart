part of 'app_cubit.dart';

class AppState extends Equatable {
  final LoadStatus fetchProfileStatus;
  final LoadStatus signOutStatus;
  final MyUserEntity? user;
  final List<MyUserEntity>? listMember;

  const AppState({
    this.fetchProfileStatus = LoadStatus.initial,
    this.signOutStatus = LoadStatus.initial,
    this.user,
    this.listMember,
  });

  AppState copyWith({
    LoadStatus? fetchProfileStatus,
    LoadStatus? signOutStatus,
    MyUserEntity? user,
    List<MyUserEntity>? listMember,
  }) {
    return AppState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      user: user ?? this.user,
      listMember: listMember ?? this.listMember,
    );
  }

  AppState removeUser() {
    return AppState(
      fetchProfileStatus: fetchProfileStatus,
      signOutStatus: signOutStatus,
      user: user,
      listMember: listMember,
    );
  }

  @override
  List<Object?> get props => [
        fetchProfileStatus,
        signOutStatus,
        user,
        listMember,
      ];
}
