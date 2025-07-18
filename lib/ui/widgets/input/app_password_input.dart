import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class ObscureTextController extends ValueNotifier<bool> {
  ObscureTextController({bool obscureText = true}) : super(obscureText);

  bool get date => value;

  set date(bool obscureText) {
    value = obscureText;
  }
}

class AppPasswordInput extends StatelessWidget {
  final String labelText;
  final TextStyle? labelStyle;
  final String highlightText;
  final Widget? suffixIcon;
  final ObscureTextController? obscureTextController;
  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final String hintText;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType textInputType;
  final FocusNode? passwordFocusNode;
  final EdgeInsets? scrollPadding;

  const AppPasswordInput({
    Key? key,
    this.labelText = "Password",
    this.labelStyle,
    this.highlightText = "*",
    this.suffixIcon,
    this.obscureTextController,
    this.textEditingController,
    this.textStyle,
    this.hintText = "",
    this.hintStyle,
    this.onChanged,
    this.onSubmitted,
    this.textInputType = TextInputType.text,
    this.passwordFocusNode,
    this.scrollPadding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: labelText,
              style: labelStyle ?? AppTextStyle.blackS12,
            ),
            TextSpan(
              text: highlightText,
              style: AppTextStyle.blackS12.copyWith(color: Colors.red),
            )
          ]),
        ),
        Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: obscureTextController!,
              child: Container(),
              builder: (context, bool obscureText, child) {
                return TextField(
                  onSubmitted: onSubmitted,
                  onChanged: onChanged,
                  controller: textEditingController,
                  focusNode: passwordFocusNode,
                  style: textStyle ?? AppTextStyle.blackS18W800,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.textFieldEnabledBorder),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.textFieldFocusedBorder),
                    ),
                    disabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.textFieldDisabledBorder),
                    ),
                    fillColor: Colors.white,
                    hintStyle: hintStyle ?? AppTextStyle.greyS16,
                    hintText: hintText,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 8, bottom: 12),
                    suffixIcon: Image.asset(
                      AppImages.icEyeOpen,
                      fit: BoxFit.fitWidth,
                      color: Colors.transparent,
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: 32, maxWidth: 32),
                  ),
                  cursorColor: AppColors.textFieldCursor,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: obscureTextController!,
              child: Container(),
              builder: (context, bool obscureText, child) {
                return _buildSuffixIcon(obscureText);
              },
            )
          ],
        ),
        textEditingController != null
            ? ValueListenableBuilder(
                valueListenable: textEditingController!,
                builder: (context, TextEditingValue controller, child) {
                  final isValid = _validatePassword(controller.text);
                  return Column(
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        isValid,
                        style:
                            AppTextStyle.blackS12.copyWith(color: Colors.red),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              )
            : Container(),
      ],
    );
  }

  Widget _buildSuffixIcon(bool obscureText) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          Future.delayed(Duration.zero, () {
            passwordFocusNode?.unfocus();
          });
          obscureTextController?.value = !obscureText;
        },
        child: Container(
          height: 34,
          width: 20,
          color: Colors.transparent,
          alignment: Alignment.centerRight,
          child: obscureText
              ? Image.asset(
                  AppImages.icEyeClose,
                  fit: BoxFit.fitWidth,
                  width: 18,
                  height: 24,
                )
              : Image.asset(
                  AppImages.icEyeOpen,
                  fit: BoxFit.fitWidth,
                  width: 18,
                  height: 24,
                ),
        ),
      ),
    );
  }

  String _validatePassword(String text) {
    return "";
  }
}
