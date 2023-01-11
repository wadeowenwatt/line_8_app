import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/row_dropdown_widget.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/row_text_field.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/text_field_custom_widget.dart';
import 'package:flutter_base/ui/widgets/input/app_email_input.dart';
import 'package:flutter_base/ui/widgets/input/app_label_text_field.dart';
import 'package:flutter_base/ui/widgets/input/dropdown_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import 'profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return ProfileCubit(
          appCubit: appCubit,
          authRepo: authRepo,
          firestoreRepo: firestoreRepo,
        );
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

class _ProfileTabPageState extends State<_ProfileTabPage> {
  late TextEditingController usernameTextController;
  late TextEditingController displayNameTextController;
  late TextEditingController phoneNumberTextController;

  late ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    usernameTextController = TextEditingController(text: "");
    displayNameTextController = TextEditingController(text: "");
    phoneNumberTextController = TextEditingController(text: "");
    _cubit = BlocProvider.of<ProfileCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
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
                      color: AppColors.primaryLightColorRight),
                  child: Container(
                    height: Get.size.height,
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
            onPressed: _updateEditData,
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
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(width: 1, color: AppColors.primaryLightColorRight),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: state.user?.urlAvatar == null
                        ? const AssetImage(AppImages.bgUserPlaceholder)
                        : NetworkImage(state.user?.urlAvatar as String)
                            as ImageProvider,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.user?.name ?? "",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${state.user?.department ?? "line X"} | E.Number: ${state.user?.employeeNumber ?? "000"}",
                      style: const TextStyle(color: Colors.grey),
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
      },
    );
  }

  Widget buildInputField() {
    return Column(
      children: [
        RowTextField(
          textField1: AppLabelTextField(
            labelText: "Name",
            highlightText: "",
            onChanged: (text) {
              _cubit.changeDisplayName(displayName: text);
            },
          ),
          textField2: AppLabelTextField(
            labelText: "Employee Number",
            highlightText: "",
            textInputType: TextInputType.number,
            onChanged: (text) {
              _cubit.changeEmployeeNumber(employeeNumber: text);
            },
          ),
        ),
        RowDropdownWidget(
          labelText1: "Position",
          dropdownWidget1: DropdownWidget(
            nameList: const [
              "Developer",
              "Line Manager",
            ],
            onChanged: (text) {
              _cubit.changePosition(position: text);
            },
          ),
          labelText2: "Department",
          dropdownWidget2: DropdownWidget(
            nameList: const ["Line 8", "Line 1", "Line 2"],
            onChanged: (text) {
              _cubit.changeDepartment(department: text);
            },
          ),
        ),
        RowTextField(
          textField1: AppLabelTextField(
            labelText: "Date of birth",
            highlightText: "",
            onChanged: (text) {
              // _cubit.changeDoB(dateOfBirth: text);
            },
          ),
          textField2: AppLabelTextField(
            labelText: "Phone Number",
            highlightText: "",
            textInputType: TextInputType.phone,
            onChanged: (text) {
              _cubit.changePhoneNumber(phoneNumber: text);
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(17),
            child: AppEmailInput(
              highlightText: "",
              onChanged: (text) {
                _cubit.changeEmail(email: text);
              },
            )),
      ],
    );
  }

  void _updateEditData() {
    _cubit.updateDataUserToFirestore();
  }
}
