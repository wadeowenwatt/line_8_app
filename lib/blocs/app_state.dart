part of 'app_cubit.dart';

class AppState extends Equatable {
  final LoadStatus fetchProfileStatus;
  final LoadStatus signOutStatus;
  final LoadStatus fetchListUserStatus;
  final MyUserEntity? user;
  final List<MyUserEntity>? listMember;
  final bool firstLogin;
  final List<Event>? listEventNotAccepted;
  final List<Event>? listEventAccepted;
  final List<Room>? listRoomHasMe;

  const AppState({
    this.fetchProfileStatus = LoadStatus.initial,
    this.signOutStatus = LoadStatus.initial,
    this.fetchListUserStatus = LoadStatus.initial,
    this.user,
    this.listMember,
    this.firstLogin = false,
    this.listEventNotAccepted,
    this.listEventAccepted,
    this.listRoomHasMe,
  });

  AppState copyWith({
    LoadStatus? fetchProfileStatus,
    LoadStatus? signOutStatus,
    LoadStatus? fetchListUserStatus,
    MyUserEntity? user,
    List<MyUserEntity>? listMember,
    bool? firstLogin,
    List<Event>? listEventNotAccepted,
    List<Event>? listEventAccepted,
    List<Room>? listRoomHasMe,
  }) {
    return AppState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      fetchListUserStatus: fetchListUserStatus ?? this.fetchListUserStatus,
      user: user ?? this.user,
      listMember: listMember ?? this.listMember,
      firstLogin: firstLogin ?? this.firstLogin,
      listEventNotAccepted: listEventNotAccepted ?? this.listEventNotAccepted,
      listEventAccepted: listEventAccepted ?? this.listEventAccepted,
      listRoomHasMe: listRoomHasMe ?? this.listRoomHasMe,
    );
  }

  AppState removeUser() {
    return AppState(
      fetchProfileStatus: fetchProfileStatus,
      signOutStatus: signOutStatus,
      fetchListUserStatus: fetchListUserStatus,
      user: user,
      listMember: listMember,
      firstLogin: firstLogin,
    );
  }

  @override
  List<Object?> get props => [
        fetchProfileStatus,
        signOutStatus,
        fetchListUserStatus,
        user,
        listMember,
        firstLogin,
        listEventNotAccepted,
        listEventAccepted,
        listRoomHasMe,
      ];
}
