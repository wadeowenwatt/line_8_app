import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/weekly_report/weekly_report_cubit.dart';
import 'package:flutter_base/ui/pages/weekly_report/widgets/report_input.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/app_cubit.dart';
import '../../../common/app_colors.dart';
import '../../../repositories/firestore_repository.dart';

class WeeklyReportPage extends StatelessWidget {
  const WeeklyReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return WeeklyReportCubit(
            firestoreRepo: firestoreRepo, appCubit: appCubit);
      },
      child: const _WeeklyReportPage(),
    );
  }
}

class _WeeklyReportPage extends StatefulWidget {
  const _WeeklyReportPage({Key? key}) : super(key: key);

  @override
  State<_WeeklyReportPage> createState() => _WeeklyReportPageState();
}

class _WeeklyReportPageState extends State<_WeeklyReportPage> {
  final _formKey = GlobalKey<FormState>();
  late WeeklyReportCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<WeeklyReportCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Weekly Report"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child: Padding(
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ReportInput(
                      label: "What I have done since the last report",
                      highlightText: " *",
                      errorText: "It cannot be blank.",
                      validation: true,
                      onChanged: (text) {
                        _cubit.changeField1(field1: text);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReportInput(
                      label: "Things or will impact my work",
                      onChanged: (text) {
                        _cubit.changeField2(field2: text);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReportInput(
                      label: "What I will do till the next report",
                      onChanged: (text) {
                        _cubit.changeField3(field3: text);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTintButton(
                      title: "Send",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _cubit.createReport();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
