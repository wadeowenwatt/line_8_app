import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiPage extends StatelessWidget {
  const WikiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WikiWebViewPage();
  }
}

class WikiWebViewPage extends StatefulWidget {
  const WikiWebViewPage({Key? key}) : super(key: key);

  @override
  State<WikiWebViewPage> createState() => _WikiWebViewPageState();
}

class _WikiWebViewPageState extends State<WikiWebViewPage> {
  bool isLoading = true;
  late WebViewController _controller;

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
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://wiki.newwave.vn'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLightColorLeft,
        title: const Text("Wiki Newwave"),
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
          Center(child: isLoading ? const CircularProgressIndicator() : const SizedBox()),
        ],
      ),
    );
  }
}
