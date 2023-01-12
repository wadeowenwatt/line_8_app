part of 'app_cubit.dart';

class AppState extends Equatable {
  final LoadStatus fetchProfileStatus;
  final LoadStatus signOutStatus;
  final MyUserEntity? user;
  final List<MyUserEntity>? listMember;
  final bool firstLogin;

  const AppState({
    this.fetchProfileStatus = LoadStatus.initial,
    this.signOutStatus = LoadStatus.initial,
    this.user,
    this.listMember,
    this.firstLogin = false,
  });

  AppState copyWith({
    LoadStatus? fetchProfileStatus,
    LoadStatus? signOutStatus,
    MyUserEntity? user,
    List<MyUserEntity>? listMember,
    bool? firstLogin,
  }) {
    return AppState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      user: user ?? this.user,
      listMember: listMember ?? this.listMember,
      firstLogin: firstLogin ?? this.firstLogin,
    );
  }

  AppState removeUser() {
    return AppState(
      fetchProfileStatus: fetchProfileStatus,
      signOutStatus: signOutStatus,
      user: user,
      listMember: listMember,
      firstLogin: firstLogin,
    );
  }

  @override
  List<Object?> get props => [
        fetchProfileStatus,
        signOutStatus,
        user,
        listMember,
        firstLogin,
      ];
}
