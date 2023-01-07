import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MemberSkillsPage extends StatelessWidget {
  const MemberSkillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _MemberSkillsPage();
  }
}

class _MemberSkillsPage extends StatefulWidget {
  const _MemberSkillsPage({Key? key}) : super(key: key);

  @override
  State<_MemberSkillsPage> createState() => _MemberSkillsPageState();
}

class _MemberSkillsPageState extends State<_MemberSkillsPage> {
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
          },
          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://docs.google.com/spreadsheets/d/1V8mNA6vt6Yk8YcaGZ_G2MIKjW735n1X_JYCS9zEzZA8/edit?usp=sharing'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLightColorLeft,
        title: const Text("Skill Members Sheet"),
        actions: [
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () => _controller.reload(),
          ),
        ],
        flexibleSpace: Image.asset(
          "assets/images/bg_appbar.png",
          fit: BoxFit.fitWidth,
          height: 100,
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          Center(child: isLoading ? const CircularProgressIndicator() : const SizedBox(),)
        ],
      ),
    );
  }
}
