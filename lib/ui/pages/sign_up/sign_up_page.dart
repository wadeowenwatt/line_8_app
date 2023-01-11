import 'package:flutter/material.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/sign_up/sign_up_cubit.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_base/ui/widgets/input/date_field_input.dart';
import 'package:flutter_base/ui/widgets/input/dropdown_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../blocs/app_cubit.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_images.dart';
import '../../../common/app_text_styles.dart';
import '../../../models/enums/load_status.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/firestore_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../widgets/input/app_email_input.dart';
import '../../widgets/input/app_label_text_field.dart';
import '../../widgets/input/app_password_input.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return SignUpCubit(
          authRepo: authRepo,
          firestoreRepo: firestoreRepo,
          appCubit: appCubit,
        );
      },
      child: const SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatefulWidget {
  const SignUpChildPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpChildPageState();
  }
}

class _SignUpChildPageState extends State<SignUpChildPage> {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;
  late TextEditingController confirmPasswordTextController;
  late TextEditingController displayNameTextController;
  late TextEditingController phoneNumberTextController;

  late ObscureTextController obscurePasswordController;
  late ObscureTextController obscureConfirmPasswordController;

  late SignUpCubit _cubit;

  @override
  void initState() {
    super.initState();
    usernameTextController = TextEditingController(text: "");
    passwordTextController = TextEditingController(text: "");
    confirmPasswordTextController = TextEditingController(text: "");
    displayNameTextController = TextEditingController(text: "");
    phoneNumberTextController = TextEditingController(text: "");
    obscurePasswordController = ObscureTextController(obscureText: true);
    obscureConfirmPasswordController = ObscureTextController(obscureText: true);
    _cubit = BlocProvider.of<SignUpCubit>(context);
    _cubit.changeEmail(email: usernameTextController.text);
    _cubit.changePassword(password: passwordTextController.text);
    _cubit.changeConfirmPassword(
        confirmPassword: confirmPasswordTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: buildBody(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildBody() {
    final showingKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final heightOfScreen = MediaQuery.of(context).size.height;
    final widthOfScreen = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.primaryDarkColorLeft,
          AppColors.primaryLightColorRight
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Stack(
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: heightOfScreen / 12),
              AspectRatio(
                aspectRatio: 5 / 1,
                child: SizedBox(
                    // height: showingKeyboard ? 0 : 100,
                    width: heightOfScreen * (1 / 6),
                    child: const Image(
                      fit: BoxFit.contain,
                      image: AssetImage(AppImages.imageDecorate),
                    )),
              ),
              SizedBox(
                // height: showingKeyboard ? 0 : 200,
                width: heightOfScreen * (1 / 4),
                child: Image.asset(AppImages.icLogoTransparentNoBackGround),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(AppImages.bgUserPlaceholder),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthOfScreen / 15),
                      child: AppEmailInput(
                        onChanged: (text) {
                          _cubit.changeEmail(email: text);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthOfScreen / 15),
                      child: AppPasswordInput(
                        obscureTextController: obscurePasswordController,
                        onChanged: (text) {
                          _cubit.changePassword(password: text);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthOfScreen / 15),
                      child: AppPasswordInput(
                        labelText: "Confirm Password",
                        obscureTextController: obscureConfirmPasswordController,
                        onChanged: (text) {
                          _cubit.changeConfirmPassword(confirmPassword: text);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthOfScreen / 15),
                      child: AppLabelTextField(
                        labelText: "Display Name",
                        highlightText: "*",
                        onChanged: (text) {
                          _cubit.changeDisplayName(displayName: text);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthOfScreen / 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Date of birth",
                                  style: AppTextStyle.blackS12,
                                ),
                                const TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          ),
                          DateField(
                            onChanged: (date) {
                              _cubit.changeDoB(dateOfBirth: date);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widthOfScreen / 15),
                        child: AppLabelTextField(
                          labelText: "Phone Number",
                          highlightText: "*",
                          textInputType: TextInputType.phone,
                          onChanged: (text) {
                            _cubit.changePhoneNumber(phoneNumber: text);
                          },
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthOfScreen / 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Position", style: AppTextStyle.blackS12),
                          DropdownWidget(
                            nameList: const [
                              "Developer",
                              "Line Manager",
                            ],
                            onChanged: (String? text) {
                              _cubit.changePosition(position: text);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthOfScreen / 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Department", style: AppTextStyle.blackS12),
                          DropdownWidget(
                            nameList: const ["Line 8", "Line 1", "Line 2"],
                            onChanged: (text) {
                              _cubit.changeDepartment(department: text);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widthOfScreen / 15),
                        child: AppLabelTextField(
                          labelText: "Employee Number",
                          highlightText: "*",
                          textInputType: TextInputType.number,
                          onChanged: (text) {
                            _cubit.changeEmployeeNumber(employeeNumber: text);
                          },
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: widthOfScreen / 15),
                          child: AppTintButton(
                            title: "Sign Up",
                            onPressed: _signUpWithEmail,
                            isLoading: state.signUpStatus == LoadStatus.loading,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                        height: showingKeyboard ? (keyboardHeight) + 20 : 200)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _signUpWithEmail() {
    _cubit.signUpWithEmail();
  }
}
