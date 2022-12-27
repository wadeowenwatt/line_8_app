import 'package:flutter/material.dart';
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
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        }))
    ..loadRequest(Uri.parse('https://wiki.newwave.vn'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wiki Newwave"),
        actions: [
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
