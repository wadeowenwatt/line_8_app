import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/ui/pages/list_member/member_profile/widgets/label_text_widget.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../blocs/app_cubit.dart';
import '../../../../common/app_images.dart';
import '../../../../repositories/firestore_repository.dart';
import 'member_profile_cubit.dart';

class MemberProfilePage extends StatelessWidget {
  MemberProfilePage({Key? key,}) : super(key: key);

  final String uid = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        return MemberProfileCubit(firestoreRepo: firestoreRepo);
      },
      child: _MemberProfilePage(uid: uid),
    );
  }
}

class _MemberProfilePage extends StatefulWidget {
  const _MemberProfilePage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<_MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<_MemberProfilePage> {
  late MemberProfileCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<MemberProfileCubit>(context);
    _cubit.fetchProfile(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MemberProfileCubit, MemberProfileState>(
          builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 230,
              floating: true,
              pinned: true,
              elevation: 1,
              backgroundColor: AppColors.primaryDarkColorLeft,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  state.user?.name ?? "Unknown",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
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
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white10),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 170),
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
            )
          ],
        );
      }),
    );
  }

  Widget _buildGeneral(MemberProfileState state) {
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
          LabelText(nameLabel: "Line", text: state.user?.department),
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

  Widget _buildMore(MemberProfileState state) {
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
