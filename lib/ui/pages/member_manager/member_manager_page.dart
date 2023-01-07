import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/models/entities/request/request_entity.dart';
import 'package:flutter_base/ui/pages/member_manager/widgets/tab_noti_badge.dart';
import 'package:get/get.dart';

import '../../../common/app_colors.dart';
import '../../../models/entities/user/new_user_entity.dart';
import 'widgets/event_card_widgets.dart';

class MemberManagerPage extends StatelessWidget {
  const MemberManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _MemberManagerPage();
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
  late int _counterRequest;
  late int _counterWeeklyReport;

  final controller = TextEditingController();
  List<User> listUser = [
    User(firstName: "Linh", lastName: "abc"),
    User(firstName: "Thong", lastName: "Nguyen"),
    User(firstName: "Yen", lastName: "Bon"),
  ];

  List<Request> listRequest = [
    Request(
        title: "Event 1",
        content: "This is Event 1 and more more more.",
        time: DateTime.now()),
    Request(
        title: "Event 2",
        content: "This is Event 1 and more more more.",
        time: DateTime.now().add(const Duration(days: 3))),
    Request(
        title: "Event 3",
        content: "This is Event 1 and more more more.",
        time: DateTime.now().add(const Duration(days: 5))),
  ];

  @override
  void initState() {
    _counterMember = 0;
    _counterRequest = 3;
    _counterWeeklyReport = 4;
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
              labelTab: "Requests",
              counter: _counterRequest,
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
            _buildRequestManage(),
            Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberManage() {
    return Column(
      children: [
        _searchBar(),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final item = listUser[index];
              return ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete"),
                        content: const Text(
                          "Are u sure about that?",
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                listUser.removeAt(index);
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
                leading: Image.asset(AppImages.bgImagePlaceholder),
                title: item.firstName == null && item.lastName == null
                    ? const Text("")
                    : Text("${item.firstName} ${item.lastName}"),
              );
            },
            itemCount: listUser.length,
          ),
        )
      ],
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

  Widget _buildRequestManage() {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = listRequest[index];
        return EventCardWidget(item: item,);
      },
      itemCount: listRequest.length,
    );
  }
}
