import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "FeedBack",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: buildBody(keyboardHeight),
    );
  }

  Widget buildBody(double keyboardHeight) {
    return SingleChildScrollView(
      physics: keyboardHeight != 0
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Give feedback",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "What do you think of the Line 8 App?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 40,
              ),

              // buildRatingWidget(),

              const SizedBox(
                height: 40,
              ),
              const Text(
                "Do you have any thoughts you'd like to share?",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: "Comment here...",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryLightColorLeft,
                    ),
                  ),
                ),
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTintButton(
                title: "Send",
                onPressed: _sendFeedback,
              ),
              keyboardHeight != 0
                  ? const SizedBox(
                      height: 20,
                    )
                  : const SizedBox(
                      height: 1000,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendFeedback() {
    /// Todo
  }
}
