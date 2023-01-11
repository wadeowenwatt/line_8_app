import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/row_text_field.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/text_field_custom_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/app_colors.dart';
import 'profile_cubit.dart';

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
      extendBodyBehindAppBar: true,
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
                    color: AppColors.primaryLightColorRight
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

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      snap: true,
      floating: true,
      pinned: true,
      title: const Text("My Profile"),
      elevation: 0,
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
              foregroundColor: Colors.grey,
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
      backgroundColor: AppColors.primaryLightColorRight,
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
              child: Align(
                alignment: AlignmentDirectional.topEnd,
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
          textField1:
              TextFieldCustom(labelText: "Phone Number", haveSuffixIcon: false),
          textField2: TextFieldCustom(labelText: "Name", haveSuffixIcon: false),
        ),
        RowTextField(
          textField1:
              TextFieldCustom(labelText: "Phone Number", haveSuffixIcon: true),
          textField2: TextFieldCustom(labelText: "Name", haveSuffixIcon: true),
        ),
        RowTextField(
          textField1:
              TextFieldCustom(labelText: "Phone Number", haveSuffixIcon: true),
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

  @override
  bool get wantKeepAlive => true;
}
