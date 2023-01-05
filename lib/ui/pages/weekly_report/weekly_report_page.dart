import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/weekly_report/widgets/report_input.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';

import '../../../common/app_colors.dart';

class WeeklyReportPage extends StatelessWidget {
  const WeeklyReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _WeeklyReportPage();
  }
}

class _WeeklyReportPage extends StatefulWidget {
  const _WeeklyReportPage({Key? key}) : super(key: key);

  @override
  State<_WeeklyReportPage> createState() => _WeeklyReportPageState();
}

class _WeeklyReportPageState extends State<_WeeklyReportPage> {
  final _formKey = GlobalKey<FormState>();

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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReportInput(
                      label: "Things or will impact my work",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReportInput(
                      label: "What I will do till the next report",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTintButton(
                      title: "Send",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          /// Todo
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
