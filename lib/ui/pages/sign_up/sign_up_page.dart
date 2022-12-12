import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/sign_up/sign_up_cubit.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_images.dart';
import '../../widgets/input/app_email_input.dart';
import '../../widgets/input/app_password_input.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignUpCubit();
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

  late ObscureTextController obscurePasswordController;
  late ObscureTextController obscureConfirmPasswordController;

  @override
  void initState() {
    super.initState();
    obscurePasswordController = ObscureTextController(obscureText: true);
    obscureConfirmPasswordController = ObscureTextController(obscureText: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBodyWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildBodyWidget() {
    final showingKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.primaryDarkColorLeft,
          AppColors.primaryLightColorRight
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          AspectRatio(
            aspectRatio: 5/1,
            child: SizedBox(
                height: showingKeyboard ? 0 : 100,
                width: 400,
                child: const Image(
                  fit: BoxFit.contain,
                  image: AssetImage(AppImages.imageDecorate),
                )),
          ),
          SizedBox(
            height: showingKeyboard ? 0 : 200,
            width: 150,
            child: Image.asset(AppImages.icLogoTransparentNoBackGround),
          ),
          _buildExpanded()
        ],
      ),
    );
  }

  Expanded _buildExpanded() {
    return Expanded(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: AppEmailInput(
                  onChanged: (text) {},
                ),
              ),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: AppPasswordInput(
                  obscureTextController: obscurePasswordController,
                  onChanged: (text) {},
                ),
              ),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: AppPasswordInput(
                  labelText: "Confirm Password",
                  obscureTextController: obscureConfirmPasswordController,
                  onChanged: (text) {},
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: AppTintButton(
                    title: "Sign Up",
                    onPressed: () {},
                  ))
            ],
          ),
        ));
  }
}
