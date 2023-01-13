import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/list_member/list_member_cubit.dart';
import 'package:flutter_base/ui/pages/list_member/widgets/item_member.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../common/app_colors.dart';
import 'member_profile/member_profile_cubit.dart';

class ListMemberPage extends StatelessWidget {
  const ListMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        return ListMemberCubit(firestoreRepository: firestoreRepo);
      },
      child: const _ListMemberPage(),
    );
  }
}

class _ListMemberPage extends StatefulWidget {
  const _ListMemberPage({Key? key}) : super(key: key);

  @override
  State<_ListMemberPage> createState() => _ListMemberPageState();
}

class _ListMemberPageState extends State<_ListMemberPage> {
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
            child: ListView.builder(
              itemBuilder: (context, index) {
                var item = state.listMember![index];
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ItemMember(
                    getMemberInfo: () {
                      _getMemberInfo(item.uid);
                    },
                    name: item.name,
                    position: item.position,
                    urlAvatar: item.urlAvatar,
                  ),
                );
              },
              itemCount:
                  state.listMember == null ? 0 : state.listMember?.length,
            ),
          ),
        );
      },
    );
  }

  void _getMemberInfo(String uid) {
    Get.toNamed(RouteConfig.memberProfile, arguments: uid);
  }
}
