import 'package:flutter/material.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/new_home/new_home_cubit.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/base_info_widget.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/big_double_card_widget.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/double_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../blocs/app_cubit.dart';
import '../../../common/app_colors.dart';
import '../main/main_cubit.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NewHomeCubit();
      },
      child: const _NewHomePage(),
    );
  }
}

class _NewHomePage extends StatefulWidget {
  const _NewHomePage({Key? key}) : super(key: key);

  @override
  State<_NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<_NewHomePage> {
  late AppCubit _appCubit;
  late MainCubit _mainCubit;

  @override
  void initState() {
    _appCubit = BlocProvider.of<AppCubit>(context);
    _mainCubit = BlocProvider.of<MainCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List choices = [
      BigChoice(
        pathImage: "assets/images/ic_fake_1.png",
        bigText: "Members",
        pathScreen: RouteConfig.memberList,
      ),
      BigChoice(
          pathImage: "assets/images/ic_fake_2.png",
          bigText: "Team Fund",
          pathScreen: RouteConfig.teamFund),
      Choice(
          title: "Calendar",
          pathImage: "assets/images/img_3.png",
          pathScreen: RouteConfig.calendar),
      Choice(
        title: "Weekly Report",
        pathImage: "assets/images/img_5.png",
        pathScreen: RouteConfig.weeklyReport,
      ),
      Choice(
          title: "Chat",
          pathImage: "assets/images/img_6.png",
          pathScreen: RouteConfig.myRoomsChat),
      Choice(
          title: "Request Seminal",
          pathImage: "assets/images/img_8.png",
          pathScreen: RouteConfig.createEvent),
      if (_appCubit.state.user?.position == "Line Manager")
      Choice(
          title: "Manager",
          pathImage: "assets/images/img_1.png",
          pathScreen: RouteConfig.memberManager),
      Choice(
          title: "Feedback",
          pathImage: "assets/images/img_2.png",
          pathScreen: RouteConfig.feedback),
      Choice(
        title: "Log out",
        pathImage: "assets/images/ic_logout.png",
        pathScreen: "",
        isLogoutButton: true,
      ),
    ];
    if (_appCubit.state.user?.position == "Developer" &&
        choices[6] ==
            Choice(
                title: "Manager",
                pathImage: "assets/images/img_1.png",
                pathScreen: RouteConfig.memberManager)) {
      choices.removeAt(6);
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColors.primaryDarkColorLeft,
          AppColors.primaryLightColorRight
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: BlocBuilder<AppCubit, AppState>(
          bloc: _appCubit,
          builder: (context, state) {
            if (state.signOutStatus == LoadStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  InformationWidget(
                    onClick: () => _moveToProfile(),
                    name: state.user?.name ?? "Unknown",
                    urlAvatar: state.user?.urlAvatar ?? "",
                    department: state.user?.department ?? "Line X",
                    employeeNumber: state.user?.employeeNumber ?? "000",
                    position: state.user?.position ?? "Unknown",
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        backgroundCard(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return RowTwoBigCardSelection(
                                choice1: choices[index],
                                choice2: choices[index + 1],
                                onClick1: () {
                                  _onClick(
                                      (choices[index] as BigChoice).pathScreen);
                                },
                                onClick2: () {
                                  _onClick((choices[index + 1] as BigChoice)
                                      .pathScreen);
                                },
                              );
                            }
                            return RowTwoCardSelection(
                              choice1: choices[index * 2],
                              choice2: (index * 2 + 1) >= choices.length
                                  ? null
                                  : choices[index * 2 + 1],
                              onClick1: () {
                                (choices[index * 2] as Choice).isLogoutButton
                                    ? _handleSignOut()
                                    : _onClick((choices[index * 2] as Choice)
                                        .pathScreen);
                              },
                              onClick2: () {
                                (index * 2 + 1) >= choices.length
                                    ? {}
                                    : (choices[index * 2 + 1] as Choice)
                                            .isLogoutButton
                                        ? _handleSignOut()
                                        : _onClick(
                                            (choices[index * 2 + 1] as Choice)
                                                .pathScreen);
                              },
                            );
                          },
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          itemCount: (choices.length / 2).round(),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget backgroundCard() {
    return Column(
      children: [
        const SizedBox(
          height: 120,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSignOut() {
    _appCubit.signOutGoogle();
    _appCubit.signOutEmail();
  }

  void _moveToProfile() {
    _mainCubit.switchTap(4);
  }

  void _onClick(String path) {
    if (path != "") {
      Get.toNamed(path);
    }
  }
}
