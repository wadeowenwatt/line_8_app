import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/ui/pages/member_manager/member_manager_cubit.dart';
import 'package:flutter_base/ui/pages/member_manager/widgets/tab_noti_badge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/app_colors.dart';
import '../../../models/entities/event/event_entity.dart';
import 'widgets/event_card_widgets.dart';

class MemberManagerPage extends StatelessWidget {
  const MemberManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return MemberManagerCubit(
            firestoreRepository: firestoreRepo, appCubit: appCubit);
      },
      child: const _MemberManagerPage(),
    );
  }
}

class _MemberManagerPage extends StatefulWidget {
  const _MemberManagerPage({Key? key}) : super(key: key);

  @override
  State<_MemberManagerPage> createState() => _MemberManagerPageState();
}

class _MemberManagerPageState extends State<_MemberManagerPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late int _counterMember;
  late int _counterWeeklyReport;
  late AppCubit _appCubit;
  late final ValueNotifier<int> _counterEvent;

  final controller = TextEditingController();
  late RefreshController refreshController;

  @override
  void initState() {
    _counterMember = 0;
    _counterWeeklyReport = 0;
    _tabController = TabController(length: 3, vsync: this);
    _appCubit = BlocProvider.of<AppCubit>(context);
    _counterEvent = ValueNotifier<int>(_appCubit.state.listEventNotAccepted!.length);
    refreshController =
        RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            TabNotiBadgeWidget(
              labelTab: "Members",
              counter: _counterMember,
              icon: const Icon(
                Icons.account_circle_rounded,
                size: 30,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _counterEvent,
              builder:(context, value, child) {
                return TabNotiBadgeWidget(
                  labelTab: "Events",
                  counter: value as int,
                  icon: const Icon(
                    Icons.receipt_long,
                    size: 30,
                  ),
                );
              },
            ),
            TabNotiBadgeWidget(
              labelTab: "Notification",
              counter: _counterWeeklyReport,
              icon: const Icon(
                Icons.notifications,
                size: 30,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryDarkColorLeft,
                AppColors.primaryLightColorRight
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildMemberManage(),
            _buildEventManage(),
            Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberManage() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            _searchBar(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var item = state.listMember![index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete"),
                                content: const Text(
                                  "Delete this user?",
                                  style: TextStyle(color: Colors.black),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        // listUser.removeAt(index);
                                        Get.back();
                                      });
                                    },
                                    child: const Text(
                                      "Delete",
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        textColor: Colors.black,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: item.urlAvatar.isNull
                              ? const AssetImage(AppImages.bgUserPlaceholder)
                              : NetworkImage(item.urlAvatar as String)
                                  as ImageProvider,
                        ),
                        title: Text("${item.name} - ${item.position}"),
                      ),
                      const Divider(),
                    ],
                  );
                },
                itemCount:
                    state.listMember == null ? 0 : state.listMember?.length,
              ),
            )
          ],
        );
      },
    );
  }

  Widget _searchBar() {
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
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _appCubit.fetchEventNotAccepted();
    _appCubit.fetchEventAccepted();
    _counterEvent.value = _appCubit.state.listEventNotAccepted!.length;
    refreshController.refreshCompleted();
  }

  Widget _buildEventManage() {
    return BlocBuilder<AppCubit, AppState>(
      bloc: _appCubit,
      builder: (context, state) {
        return SmartRefresher(
          controller: refreshController,
          onRefresh: _onRefresh,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final item = state.listEventNotAccepted![index];
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Approval"),
                        content: const Text(
                          "Request Approval",
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _appCubit.acceptEvent(state.listEventNotAccepted![index].id);
                                _onRefresh();
                                Get.back();
                              });
                            },
                            child: const Text(
                              "Accept",
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _appCubit.rejectEvent(state.listEventNotAccepted![index].id);
                              _onRefresh();
                              Get.back();
                            },
                            child: const Text(
                              "Reject",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                child: EventCardWidget(
                  item: item,
                ),
              );
            },
            itemCount: state.listEventNotAccepted!.length,
          ),
        );
      },
    );
  }
}
