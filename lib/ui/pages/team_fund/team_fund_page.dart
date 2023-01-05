import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/currency_textfield.dart';

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
                Expanded(child: buildHistoryInfo()),
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
              "Tổng tiền trong quỹ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CurrencyTextField(moneyCounter: 100000000),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
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
                    "Nạp tiền",
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

  Widget buildHistoryInfo() {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Lịch sử",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),

          ],
        ),
      ),
    );
  }
}
