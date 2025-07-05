import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../blocs/app_cubit.dart';
import '../../../repositories/firestore_repository.dart';
import 'feedback_cubit.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      final firestoreRepo =
      RepositoryProvider.of<FirestoreRepository>(context);
      final appCubit = RepositoryProvider.of<AppCubit>(context);
      return FeedbackCubit(
        firestoreRepo: firestoreRepo,
        appCubit: appCubit,
      );
    },
      child: const _FeedbackPage(),);
  }
}


class _FeedbackPage extends StatefulWidget {
  const _FeedbackPage({Key? key}) : super(key: key);

  @override
  State<_FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<_FeedbackPage> {

  late FeedbackCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<FeedbackCubit>(context);
    super.initState();
  }

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
              buildRatingWidget(),
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
                onChanged: (text) {
                  _cubit.changeComment(text);
                },
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
    _cubit.sendFeedback();
  }

  Widget buildRatingWidget() {
    return Center(
      child: RatingBar.builder(
        itemPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const Icon(
                Icons.sentiment_very_dissatisfied,
                color: Colors.red,
              );
            case 1:
              return const Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.redAccent,
              );
            case 2:
              return const Icon(
                Icons.sentiment_neutral,
                color: Colors.amber,
              );
            case 3:
              return const Icon(
                Icons.sentiment_satisfied,
                color: Colors.lightGreen,
              );
            default:
              return const Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.green,
              );
          }
        },
        onRatingUpdate: (rating) {
          _cubit.changeRate(rating);
        },
      ),
    );
  }
}
