import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';

import '../app_circular_progress_indicator.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  final bool isLoading;

  final double? height;
  final double? width;
  final double? borderWidth;
  final double? cornerRadius;

  final Color? backgroundColor;
  final Color? borderColor;

  final TextStyle? textStyle;

  final VoidCallback? onPressed;
  final Gradient? gradient;

  const AppButton(
      {Key? key,
      this.title,
      this.leadingIcon,
      this.trailingIcon,
      this.isLoading = false,
      this.height,
      this.width,
      this.borderWidth,
      this.cornerRadius,
      this.backgroundColor,
      this.borderColor,
      this.textStyle,
      this.onPressed,
      this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppDimens.buttonHeight,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          gradient: gradient ??
              const LinearGradient(colors: [
                AppColors.primaryDarkColorLeft,
                AppColors.primaryLightColorRight
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                cornerRadius ?? AppDimens.buttonCornerRadius),
          ),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          padding: const EdgeInsets.all(0),
        ),
        onPressed: onPressed,
        child: _buildChildWidget(),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator(color: Colors.white);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIcon ?? Container(),
          title != null
              ? Text(
                  title!,
                  style: textStyle ??
                      const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.red),
                )
              : Container(),
          trailingIcon ?? Container(),
        ],
      );
    }
  }
}
