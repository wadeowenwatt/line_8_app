import 'package:flutter/material.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/ui/pages/team_fund/widgets/currency_textfield.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/app_colors.dart';

class TeamFundPage extends StatelessWidget {
  const TeamFundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _TeamFundPage();
  }
}

class _TeamFundPage extends StatefulWidget {
  const _TeamFundPage({Key? key}) : super(key: key);

  @override
  State<_TeamFundPage> createState() => _TeamFundPageState();
}

class _TeamFundPageState extends State<_TeamFundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Team Fund",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
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
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top,
                ),
                Padding(padding: const EdgeInsets.all(20), child: buildCard()),
                Expanded(
                  child: _InfoFundWebview(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard() {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quỹ team",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CurrencyTextField(moneyCounter: 1000000),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      child: Container(
                        height: Get.width * 0.7 * (4 / 3.5),
                        width: Get.width * 0.7,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/qr_code.jpg'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.grey,
                padding: const EdgeInsets.only(right: 10, left: 10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Đóng quỹ",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _InfoFundWebview extends StatefulWidget {
  const _InfoFundWebview({
    super.key,
  });

  @override
  State<_InfoFundWebview> createState() => _InfoFundWebviewState();
}

class _InfoFundWebviewState extends State<_InfoFundWebview> {

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
      ..loadRequest(Uri.parse('https://docs.google.com/spreadsheets/d/1dFAO2HYUC7BcEYpJHe9WKVD7DQLgsdHPXnhZ9yIBNkw/edit#gid=641547926'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            WebViewWidget(
              controller: _controller,
            ),
            Center(child: isLoading ? const CircularProgressIndicator() : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
