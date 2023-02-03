

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../blocs/app_cubit.dart';
import '../../../../common/app_colors.dart';
import '../../../../models/entities/user/my_user_entity.dart';
import '../../../../repositories/chat_repository.dart';
import '../../list_member/widgets/item_member.dart';
import 'list_member_chat_cubit.dart';

class ListMemberChatPage extends StatelessWidget {
  const ListMemberChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final chatRepo =
        RepositoryProvider.of<ChatRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return ListMemberChatCubit(
          chatRepo: chatRepo,
          appCubit: appCubit,
        );
      },
      child: const _ListMemberChatPage(),
    );
  }
}

class _ListMemberChatPage extends StatefulWidget {
  const _ListMemberChatPage({Key? key}) : super(key: key);

  @override
  State<_ListMemberChatPage> createState() => _ListMemberChatPageState();
}

class _ListMemberChatPageState extends State<_ListMemberChatPage> {
  final controller = TextEditingController();
  late List<MyUserEntity> _listMemberForSearching;

  late AppCubit _appCubit;

  @override
  void initState() {
    _appCubit = BlocProvider.of<AppCubit>(context);
    _listMemberForSearching = List.from(_appCubit.state.listMember as Iterable) ?? [];
    for (var element in _listMemberForSearching) {
      if (element.uid == _appCubit.state.user!.uid) {
        _listMemberForSearching.remove(element);
        break;
      }
    }
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
        title: const Text("List Member"),
        backgroundColor: AppColors.primaryLightColorLeft,
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
                _searchBar(state),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var item = _listMemberForSearching[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: ItemMember(
                          /// In this attribute, create a room chat.
                          getMemberInfo: () {
                            _createRoom(state.user!.uid, item.uid);
                          },
                          name: item.name,
                          position: item.position,
                          urlAvatar: item.urlAvatar,
                        ),
                      );
                    },
                    itemCount: _listMemberForSearching.length,
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
        onChanged: (query) => _searchMember(query, state),
      ),
    );
  }

  void _searchMember(String query, AppState state) {
    final resultList = state.listMember!.where((member) {
      final name = member.name?.toLowerCase() ?? "";
      final lowCaseQuery = query.toLowerCase();

      return name.contains(lowCaseQuery);
    }).toList();

    setState(() {
      _listMemberForSearching = resultList;
    });
  }

  void _createRoom(String currentUid, String guestUid) {
    _appCubit.createRoomChat(currentUid, guestUid);
    Get.back();
  }

}
