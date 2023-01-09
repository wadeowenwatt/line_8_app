import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_base/ui/widgets/input/app_email_input.dart';
import 'package:flutter_base/ui/widgets/input/app_password_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../repositories/auth_repository.dart';
import '../../../repositories/user_repository.dart';
import 'sign_in_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return SignInCubit(
          authRepo: authRepo,
          userRepo: userRepo,
          firestoreRepo: firestoreRepo,
          appCubit: appCubit,
        );
      },
      child: const SignInChildPage(),
    );
  }
}

class SignInChildPage extends StatefulWidget {
  const SignInChildPage({Key? key}) : super(key: key);

  @override
  State<SignInChildPage> createState() => _SignInChildPageState();
}

class _SignInChildPageState extends State<SignInChildPage> {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;

  late ObscureTextController obscurePasswordController;

  late SignInCubit _cubit;

  late bool showingKeyboard = false;
  late double keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    usernameTextController = TextEditingController(text: '');
    passwordTextController = TextEditingController(text: "");
    obscurePasswordController = ObscureTextController(obscureText: true);
    _cubit = BlocProvider.of<SignInCubit>(context);
    _cubit.changeUsername(username: usernameTextController.text);
    _cubit.changePassword(password: passwordTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(), child: buildBodyWidget()),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildBodyWidget() {
    showingKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
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
          const AspectRatio(
            aspectRatio: 5 / 1,
            child: SizedBox(
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage(AppImages.imageDecorate),
              ),
            ),
          ),
          SizedBox(
            height: showingKeyboard ? 0 : 200,
            width: 150,
            child: Image.asset(AppImages.icLogoTransparentNoBackGround),
          ),
          _buildCardScroll(),
        ],
      ),
    );
  }

  Widget _buildCardScroll() {
    return Container(
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
              textEditingController: usernameTextController,
              onChanged: (text) {
                _cubit.changeUsername(username: text);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: AppPasswordInput(
              obscureTextController: obscurePasswordController,
              textEditingController: passwordTextController,
              onChanged: (text) {
                _cubit.changePassword(password: text);
              },
            ),
          ),
          _buildButton(),
          SizedBox(
            height: showingKeyboard ? (keyboardHeight) + 20 : 150,
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AppTintButton(
                title: S.of(context).button_signIn,
                onPressed: _signInWithEmail,
              ),
              const SizedBox(
                height: 10,
              ),
              SignInButton(
                Buttons.Google,
                onPressed: _signInWithGoogle,
              ),
              (state.signInWithGoogleStatus == LoadStatus.loading ||
                      state.signInWithEmailStatus == LoadStatus.loading)
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot password"),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        _signUp();
                      },
                      child: const Text("Register now"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _signInWithEmail() {
    _cubit.signInWithEmail();
  }

  void _signInWithGoogle() {
    _cubit.signInWithGoogle();
  }

  void _signUp() {
    Get.toNamed(RouteConfig.signUp);
  }
}
