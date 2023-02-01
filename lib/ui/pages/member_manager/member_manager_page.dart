import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/models/entities/request/request_entity.dart';
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
  late int _counterEvent;
  late int _counterWeeklyReport;

  final controller = TextEditingController();

  List<Event> listEvent = [
    Event(
      id: 'cyclic_event',
      title: "Tech-Talk",
      timeStart: Timestamp.fromDate(DateTime.now()),
      timeStop: Timestamp.fromDate(DateTime.now()),
      details: "Tech-Talk hằng tuần",
      requested: true,
    ),
    Event(
      id: 'cyclic_event',
      title: "Tech-Talk",
      timeStart: Timestamp.fromDate(DateTime.now()),
      timeStop: Timestamp.fromDate(DateTime.now()),
      details: "Tech-Talk hằng tuần",
      requested: true,
    ),
    Event(
      id: 'cyclic_event',
      title: "Tech-Talk",
      timeStart: Timestamp.fromDate(DateTime.now()),
      timeStop: Timestamp.fromDate(DateTime.now()),
      details: "Tech-Talk hằng tuần",
      requested: true,
    ),
  ];

  @override
  void initState() {
    _counterMember = 0;
    _counterEvent = 3;
    _counterWeeklyReport = 0;
    _tabController = TabController(length: 3, vsync: this);
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
            TabNotiBadgeWidget(
              labelTab: "Events",
              counter: _counterEvent,
              icon: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
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

  Widget _buildEventManage() {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return BlocBuilder<MemberManagerCubit, MemberManagerState>(
      builder: (context, state) {
        return SmartRefresher(
          controller: refreshController,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final item = listEvent[index];
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
                                // listUser.removeAt(index);
                                Get.back();
                              });
                            },
                            child: const Text(
                              "Accept",
                            ),
                          ),
                          TextButton(
                            onPressed: () {
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
            itemCount: listEvent.length,
          ),
        );
      },
    );
  }
}
