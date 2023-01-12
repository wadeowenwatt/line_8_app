import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/ui/pages/list_member/member_profile/widgets/label_text_widget.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/app_cubit.dart';
import '../../../../common/app_images.dart';

class MemberProfilePage extends StatefulWidget {
  const MemberProfilePage({Key? key}) : super(key: key);

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 280,
                  floating: true,
                  snap: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryLightColorLeft,
                            AppColors.primaryLightColorRight
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                              height: AppBar().preferredSize.height +
                                  MediaQuery.of(context).padding.top),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage: state.user?.urlAvatar == null
                                ? const AssetImage(AppImages.bgUserPlaceholder)
                                : NetworkImage(state.user?.urlAvatar as String)
                            as ImageProvider,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              state.user?.name ?? "Unknown",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(state.user?.employeeNumber ?? "000"),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
              body: Container(
                decoration: const BoxDecoration(color: Colors.white10),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  shrinkWrap: true,
                  children: [
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: _buildGeneral(state),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: _buildMore(state),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  Widget _buildGeneral(AppState state) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "General",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          LabelText(
              nameLabel: "Date of birth",
              text: state.user?.dateOfBirth?.toDate().toDateString()),
          const Divider(thickness: 1),
          LabelText(nameLabel: "Position", text: state.user?.position),
          const Divider(thickness: 1),
          LabelText(nameLabel: "Department", text: state.user?.department),
          const Divider(thickness: 1),
          LabelText(
              nameLabel: "Employee number", text: state.user?.employeeNumber),
          const Divider(thickness: 1),
          LabelText(nameLabel: "Phone number", text: state.user?.phoneNumber),
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  Widget _buildMore(AppState state) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "More",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          LabelText(nameLabel: "Email", text: state.user?.email),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
