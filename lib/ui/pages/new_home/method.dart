
part of 'new_home_page.dart';

extension MethodExtension on NewHomePage{
  Widget backgroundCard() {
    return Column(
      children: [
        const SizedBox(
          height: 120,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }
}