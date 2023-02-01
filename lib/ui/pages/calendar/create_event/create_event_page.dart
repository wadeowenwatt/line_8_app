import 'package:flutter/material.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/calendar/create_event/create_event_cubit.dart';
import 'package:flutter_base/ui/pages/calendar/create_event/widgets/icon_double_textfield_widget.dart';
import 'package:flutter_base/ui/pages/calendar/create_event/widgets/icon_textfield_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../common/app_colors.dart';
import '../../../commons/app_snackbar.dart';
import '../../../widgets/buttons/app_tint_button.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final firestoreRepo =
        RepositoryProvider.of<FirestoreRepository>(context);
        return CreateEventCubit(firestoreRepo: firestoreRepo);
      },
      child: const _CreateEventPage(),
    );
  }
}

class _CreateEventPage extends StatefulWidget {
  const _CreateEventPage({Key? key}) : super(key: key);

  @override
  State<_CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<_CreateEventPage> {

  late CreateEventCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<CreateEventCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text("Request Seminal"),
            backgroundColor: AppColors.primaryLightColorLeft,
            actions: [
              // IconButton(
              //   onPressed: () {
              //     Get.back();
              //   },
              //   icon: const Icon(Icons.done),
              // ),
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: AppColors.primaryDarkColorLeft,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: BlocBuilder<CreateEventCubit, CreateEventState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          IconTextField(
                            icon: const Icon(Icons.search),
                            labelText: "Title",
                            onChanged: (text) {
                              _cubit.changeTitle(title: text);
                            },
                          ),
                          IconDoubleTextField(
                            icon: const Icon(Icons.access_time),
                            topLabelText: "Start",
                            bottomLabelText: "End",
                            onChangedTimeStart: (dateTime) {
                              _cubit.changeTimeStart(timeStart: dateTime);
                            },
                            onChangedTimeStop: (dateTime) {
                              _cubit.changeTimeStop(timeStop: dateTime);
                            },
                          ),
                          IconTextField(
                            icon: const Icon(Icons.sticky_note_2_outlined),
                            labelText: "Details",
                            onChanged: (details) {
                              _cubit.changeDetails(details: details);
                            },
                          ),
                          // IconTextField(
                          //   icon: const Icon(Icons.email),
                          //   labelText: "Email user create",
                          //   isEmailInput: true,
                          // ),
                          // IconTextField(
                          //     icon: const Icon(Icons.add_location),
                          //     labelText: "Location"),
                          // IconTextField(
                          //   icon: const Icon(Icons.notifications),
                          //   labelText: "Set time notification",
                          // ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppTintButton(title: "Send", onPressed: _sendRequest),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _sendRequest() async {
    await _cubit.createEvent();
    if (_cubit.state.createEventStatus == LoadStatus.success) {
      Get.back();
      AppSnackbar.showInfo(message: "Create request completed!");
    }
  }
}
