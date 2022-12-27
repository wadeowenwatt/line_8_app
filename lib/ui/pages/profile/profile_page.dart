import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/setting/setting_page.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../common/app_colors.dart';
import '../../widgets/images/app_circle_avatar.dart';
import 'profile_cubit.dart';
import 'widgets/menu_header_widget.dart';
import 'widgets/menu_item_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileCubit();
      },
      child: const _ProfileTabPage(),
    );
  }
}

class _ProfileTabPage extends StatefulWidget {
  const _ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<_ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<_ProfileTabPage>
    with AutomaticKeepAliveClientMixin {
  late AppCubit _appCubit;

  @override
  void initState() {
    _appCubit = BlocProvider.of<AppCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryLightColorLeft,
                        AppColors.primaryLightColorRight,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        buildInfoCard(),
                        buildInputField(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      // margin: EdgeInsets.all(20),
      // height: 60,
      // preferredSize: Size(double.infinity, 60),
      toolbarHeight: 56,
      leading: Container(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<AppCubit, AppState>(
          bloc: _appCubit,
          builder: (context, state) {
            return AppCircleAvatar(url: state.user?.avatarUrl ?? "", size: 48);
          },
        ),
      ),
      title: Row(
        children: [
          // AppCircleAvatar(url: state.user.value?.avatarUrl ?? "", size: 60),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<AppCubit, AppState>(
                  bloc: _appCubit,
                  builder: (context, state) {
                    return Text(
                      state.user?.username ?? "",
                      style: theme.textTheme.headline6,
                    );
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  "View profile",
                  style: theme.textTheme.subtitle2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      snap: true,
      floating: true,
      leading: IconButton(
        onPressed: () {},
        icon: Image.asset(
          'assets/images/ic_back_arrow.png',
          fit: BoxFit.fitWidth,
          height: 25,
        ),
      ),
      title: const Text("My Profile"),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.only(right: 10, left: 10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/ic_done_button.png',
                  color: AppColors.primaryLightColorLeft,
                  fit: BoxFit.contain,
                  height: 10,
                  width: 30,
                ),
                const Text(
                  "Done",
                  style: TextStyle(color: AppColors.primaryLightColorLeft),
                ),
              ],
            ),
          ),
        ),
      ],
      flexibleSpace: Stack(
        children: [
          Image.asset(
            "assets/images/bg_appbar.png",
            fit: BoxFit.fitWidth,
            height: 100,
          ),
        ],
      ),
      backgroundColor: AppColors.primaryLightColorLeft,
    );
  }

  Widget buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: AppColors.primaryLightColorRight),
        ),
        child: Row(
          children: [
            Card(
              margin: const EdgeInsets.all(12),
              child: Image.asset(
                "assets/images/bg_image_placeholder.png",
                width: 100,
                height: 100,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Linh Tran",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Class XI-B | Roll no: 04",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Expanded(
              child: IconButton(
                icon: Image.asset(
                  "assets/images/ic_camera.png",
                  width: 30,
                  height: 25,
                  fit: BoxFit.fitHeight,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField() {
    return Column(
      children: const [
        RowTextField(
          textField1: TextFieldCustom(labelText: "Phone Number", haveSuffixIcon: false),
          textField2: TextFieldCustom(labelText: "Name", haveSuffixIcon: false),
        ),
        RowTextField(
          textField1: TextFieldCustom(labelText: "Phone Number", haveSuffixIcon: true),
          textField2: TextFieldCustom(labelText: "Name", haveSuffixIcon: true),
        ),
        RowTextField(
          textField1: TextFieldCustom(labelText: "Phone Number", haveSuffixIcon: true),
          textField2: TextFieldCustom(labelText: "Name", haveSuffixIcon: true),
        ),
        Padding(
          padding: EdgeInsets.all(17),
          child: TextFieldCustom(
            labelText: "Email",
            haveSuffixIcon: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(17),
          child: TextFieldCustom(
            labelText: "Email",
            haveSuffixIcon: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(17),
          child: TextFieldCustom(
            labelText: "Email",
            haveSuffixIcon: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(17),
          child: TextFieldCustom(
            labelText: "Email",
            haveSuffixIcon: true,
          ),
        ),
      ],
    );
  }

  Widget buildSignOutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (prev, current) {
          return prev.signOutStatus != current.signOutStatus;
        },
        builder: (context, state) {
          return AppTintButton(
            title: 'Logout',
            isLoading: state.signOutStatus == LoadStatus.loading,
            onPressed: _handleSignOut,
          );
        },
      ),
    );
  }

  Widget buildMenusWidget() {
    return Column(
      children: [
        const MenuHeaderWidget(title: "Lists"),
        // MenuItemWidget(title: "Watchlist"),
        const MenuItemWidget(title: "History"),
        // MenuItemWidget(title: "Collection"),
        // MenuItemWidget(title: "Personal Lists"),
        // MenuItemWidget(title: "Reminders"),
        // MenuItemWidget(title: "Hidden Items"),
        const MenuHeaderWidget(title: "Settings"),
        // MenuItemWidget(title: "Go Premium"),
        MenuItemWidget(
          title: "Settings",
          onPressed: () {
            Get.to(() => const SettingPage());
          },
        ),
        const MenuItemWidget(title: "Help & feedback"),
        const MenuItemWidget(title: "About"),
      ],
    );
  }

  void _handleSignOut() {
    BlocProvider.of<AppCubit>(context).signOut();
  }

  @override
  bool get wantKeepAlive => true;
}

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    required this.labelText,
    required this.haveSuffixIcon,
  });

  final String labelText;
  final bool haveSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
        suffixIcon: haveSuffixIcon
            ? Image.asset(
                "assets/images/ic_suffix_textfield.png",
              )
            : null,
      ),
    );
  }
}

class RowTextField extends StatelessWidget {
  const RowTextField({
    super.key,
    required this.textField1,
    required this.textField2,
  });

  final TextFieldCustom textField1;
  final TextFieldCustom textField2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Row(
        children: [
          Expanded(
            child: textField1
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: textField2
          )
        ],
      ),
    );
  }
}
