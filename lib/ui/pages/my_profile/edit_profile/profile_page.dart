import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/firestorage_repository.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/my_profile/edit_profile/profile_state.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/row_dropdown_widget.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/row_text_field.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/text_field_custom_widget.dart';
import 'package:flutter_base/ui/widgets/input/app_email_input.dart';
import 'package:flutter_base/ui/widgets/input/app_label_text_field.dart';
import 'package:flutter_base/ui/widgets/input/date_field_input.dart';
import 'package:flutter_base/ui/widgets/input/dropdown_widget.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
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
        final storageRepo =
            RepositoryProvider.of<FireStorageRepository>(context);
        return ProfileCubit(
          appCubit: appCubit,
          authRepo: authRepo,
          firestoreRepo: firestoreRepo,
          storageRepo: storageRepo,
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
  late TextEditingController emailTextController;
  late TextEditingController employeeTextController;
  late TextEditingController dateOfBirthTextController;
  late TextEditingController displayNameTextController;
  late TextEditingController phoneNumberTextController;

  late ProfileCubit _cubit;
  late AppCubit _appCubit;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController(text: "");
    displayNameTextController = TextEditingController(text: "");
    phoneNumberTextController = TextEditingController(text: "");
    employeeTextController = TextEditingController(text: "");
    dateOfBirthTextController = TextEditingController(text: "");
    _cubit = BlocProvider.of<ProfileCubit>(context);
    _appCubit = BlocProvider.of<AppCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Container(
              decoration:
                  const BoxDecoration(color: AppColors.primaryLightColorLeft),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    buildInfoCard(),
                    buildInputField(),
                    const SizedBox(height: 100,),
                  ],
                ),
              ),
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
      backgroundColor: AppColors.primaryLightColorLeft,
    );
  }

  Widget buildInfoCard() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
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
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: state.tempAvatar.isNull
                            ? appState.user?.urlAvatar == null
                                ? const AssetImage(AppImages.bgUserPlaceholder)
                                : NetworkImage(
                                        appState.user?.urlAvatar as String)
                                    as ImageProvider
                            : FileImage(File(state.tempAvatar!.path)),
                      ),
                    );
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appState.user?.name ?? "",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${appState.user?.department ?? "line X"} | E.Number: ${appState.user?.employeeNumber ?? "000"}",
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
                      onPressed: () {
                        _pickImage(context);
                      },
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
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        _cubit.changeDisplayName(displayName: state.user?.name ?? "");
        _cubit.changeEmployeeNumber(
            employeeNumber: state.user?.employeeNumber ?? "000");
        _cubit.changeDoB(
            dateOfBirth: state.user?.dateOfBirth == null
                ? Timestamp.fromDate(DateTime(1900)).toDate()
                : state.user?.dateOfBirth?.toDate() as DateTime);
        _cubit.changePhoneNumber(phoneNumber: state.user?.phoneNumber ?? "");
        _cubit.changeEmail(email: state.user?.email ?? "");
        _cubit.changePosition(position: state.user?.position);
        _cubit.changeDepartment(department: state.user?.department);
        return Column(
          children: [
            RowTextField(
              textField1: AppLabelTextField(
                labelText: "Name",
                highlightText: "",
                enableValidate: false,
                textEditingController:
                    TextEditingController(text: state.user?.name),
                onChanged: (text) {
                  _cubit.changeDisplayName(displayName: text);
                },
              ),
              textField2: AppLabelTextField(
                labelText: "Employee Number",
                enableValidate: false,
                highlightText: "",
                textEditingController: TextEditingController(
                    text: state.user?.employeeNumber ?? "000"),
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
                ],
                currentValue: state.user?.position,
                onChanged: (text) {
                  _cubit.changePosition(position: text);
                },
              ),
              labelText2: "Line",
              dropdownWidget2: DropdownWidget(
                nameList: const ["Line 8", "Line 1", "Line 2"],
                currentValue: state.user?.department,
                onChanged: (text) {
                  _cubit.changeDepartment(department: text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17),
              child: Row(
                children: [
                  Expanded(
                    child: DateField(
                      labelText: "Date of birth",
                      currentValue:
                          state.user?.dateOfBirth?.toDate().toDateString(),
                      textEditingController: TextEditingController(
                          text:
                              state.user?.dateOfBirth?.toDate().toDateString()),
                      onChanged: (date) {
                        _cubit.changeDoB(dateOfBirth: date);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: AppLabelTextField(
                      labelText: "Phone Number",
                      highlightText: "",
                      enableValidate: false,
                      textEditingController:
                          TextEditingController(text: state.user?.phoneNumber),
                      textInputType: TextInputType.phone,
                      onChanged: (text) {
                        _cubit.changePhoneNumber(phoneNumber: text);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(17),
                child: AppEmailInput(
                  highlightText: "",
                  textEditingController:
                      TextEditingController(text: state.user?.email),
                  onChanged: (text) {
                    _cubit.changeEmail(email: text);
                  },
                )),
          ],
        );
      },
    );
  }

  void _updateEditData() async {
    await _cubit.updateDataUserToFirestore();
    if (_appCubit.isFirstLogin()) {
      _appCubit.fetchListUser();
      _appCubit.changedStateFirstLogin(false);
      Get.offNamed(RouteConfig.main);
    }
    _appCubit.fetchListUser();
    Get.back();
  }

  void _pickImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title:
                  const Text("Camera", style: TextStyle(color: Colors.black)),
              onTap: () {
                Get.back();
                _cubit.pickImageCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title:
                  const Text("Gallery", style: TextStyle(color: Colors.black)),
              onTap: () {
                Get.back();
                _cubit.pickImageGallery();
              },
            ),
          ],
        );
      },
    );
  }
}
