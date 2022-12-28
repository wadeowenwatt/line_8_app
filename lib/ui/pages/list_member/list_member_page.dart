import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_images.dart';

import '../../../common/app_colors.dart';

class ListMemberPage extends StatefulWidget {
  const ListMemberPage({Key? key}) : super(key: key);

  @override
  State<ListMemberPage> createState() => _ListMemberPageState();
}

class _ListMemberPageState extends State<ListMemberPage> {
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
}

Widget buildBody() {
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
          return const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: ItemMember(),
          );
        },
        itemCount: 12,
      ),
    ),
  );
}

class ItemMember extends StatelessWidget {
  const ItemMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _getMemberInfo(),
      child: Card(
        color: AppColors.selectCardColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                child: Image.asset(AppImages.bgImagePlaceholder),
              ),
              const SizedBox(width: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Name Member",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Member",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _getMemberInfo() {

  }
}
