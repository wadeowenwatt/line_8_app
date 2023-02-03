import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';
import 'package:flutter_base/ui/pages/my_rooms_chat/my_rooms_chat_cubit.dart';
import 'package:flutter_base/ui/pages/my_rooms_chat/widgets/item_room.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../blocs/app_cubit.dart';
import '../../../common/app_colors.dart';
import '../../../models/entities/chat/room_entity.dart';
import '../../../repositories/firestore_repository.dart';
import '../../../router/route_config.dart';

class MyRoomsChatPage extends StatelessWidget {
  const MyRoomsChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return MyRoomsChatCubit(
            // firestoreRepository: firestoreRepo,
            // appCubit: appCubit,
            );
      },
      child: const _MyRoomsChatPage(),
    );
  }
}

class _MyRoomsChatPage extends StatefulWidget {
  const _MyRoomsChatPage({Key? key}) : super(key: key);

  @override
  State<_MyRoomsChatPage> createState() => _MyRoomsChatPageState();
}

class _MyRoomsChatPageState extends State<_MyRoomsChatPage> {
  final controller = TextEditingController();
  late List<Room> _listRoomForSearching;

  late AppCubit _appCubit;

  @override
  void initState() {
    _appCubit = BlocProvider.of<AppCubit>(context);
    _listRoomForSearching = _appCubit.state.listRoomHasMe ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          "assets/images/bg_appbar.png",
          fit: BoxFit.fitWidth,
          height: 100,
        ),
        elevation: 0,
        title: const Text("My Rooms Chat"),
        backgroundColor: AppColors.primaryLightColorLeft,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(RouteConfig.memberListChat);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.primaryLightColorLeft,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                // _searchBar(state),
                const SizedBox(
                  height: 10,
                ),

                Expanded(
                  child: state.listRoomHasMe!.isEmpty
                      ? const Center(
                          child: Text(
                            "Empty :D",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            var room = state.listRoomHasMe![index];

                            String? guestUid;
                            String? currentUid;
                            for (var id in room.listUidParticipants) {
                              id != state.user!.uid
                                  ? guestUid = id
                                  : currentUid = id;
                            }

                            MyUserEntity? guestUser =
                                _getGuest(state, guestUid);

                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: ItemRoom(
                                getRoomInfo: () {
                                  _getRoomChat(
                                    room.id ?? "",
                                    currentUid: currentUid,
                                    guestUid: guestUid,
                                  );
                                },
                                name: guestUser!.name,
                                // newMessage: guestUser.newMessage,
                                urlAvatar: guestUser.urlAvatar,
                              ),
                            );
                          },
                          itemCount: state.listRoomHasMe!.length,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchBar(AppState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.primaryLightColorLeft),
          ),
          hintText: "Search...",
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.primaryLightColorLeft),
          ),
        ),
        // onChanged: (query) => _searchMember(query, state),
      ),
    );
  }

  // void _searchMember(String query, AppState state) {
  //   final resultList = state.listMember!.where((member) {
  //     final name = member.name?.toLowerCase() ?? "";
  //     final lowCaseQuery = query.toLowerCase();
  //
  //     return name.contains(lowCaseQuery);
  //   }).toList();
  //
  //   setState(() {
  //     _listMemberForSearching = resultList;
  //   });
  // }

  void _getRoomChat(String roomId, {String? currentUid, String? guestUid}) {
    Get.toNamed(RouteConfig.chat, arguments: [roomId, currentUid, guestUid]);
  }

  MyUserEntity? _getGuest(AppState state, String? guestUid) {
    for (var mem in state.listMember!) {
      if (mem.uid == guestUid) {
        return mem;
      }
    }
    return null;
  }
}
