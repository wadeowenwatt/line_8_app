import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/enums/message_type.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

class AppDialog {
  static void defaultDialog({
    String title = "Alert",
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      onConfirm: onConfirm == null
          ? null
          : () {
              Get.back();
              onConfirm.call();
            },
      onCancel: onCancel == null
          ? null
          : () {
              Get.back();
              onCancel.call();
            },
      textConfirm: textConfirm,
      textCancel: textCancel,
    );
  }

  static void showDatePicker(
    BuildContext context, {
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onConfirm,
    LocaleType locale = LocaleType.en,
    DateTime? currentTime,
  }) {
    DatePicker.showDatePicker(
      context,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: onConfirm,
      locale: LocaleType.vi,
      currentTime: currentTime,
      theme: const DatePickerTheme(),
    );
  }

  static void showDateTimePicker(
    BuildContext context, {
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onConfirm,
    LocaleType locale = LocaleType.en,
    DateTime? currentTime,
  }) {
    DatePicker.showDateTimePicker(
      context,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: onConfirm,
      locale: LocaleType.vi,
      currentTime: currentTime,
      theme: const DatePickerTheme(),
    );
  }

  static void showLoadingDialog() {
    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showVideoDialog(ChewieController controller) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Get.size.width * 0.7,
            maxHeight: Get.size.height * 0.6,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Chewie(
            controller: controller,
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void showPickOptions({required Function(MessageType) onPressed}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.bottomCenter,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                children: [
                  OptionItem(
                    onPressed: () => onPressed(MessageType.image),
                    title: "Image",
                    backgroundColor: Colors.white,
                    iconData: Icons.photo,
                  ),
                  OptionItem(
                    onPressed: () => onPressed(MessageType.file),
                    title: "File",
                    backgroundColor: AppColors.whiteAccent,
                    iconData: Icons.file_present_outlined,
                  ),
                  OptionItem(
                    onPressed: () => onPressed(MessageType.video),
                    title: "Video",
                    backgroundColor: Colors.white,
                    iconData: Icons.video_file_outlined,
                  ),
                  OptionItem(
                    onPressed: () => onPressed(MessageType.audio),
                    title: "Audio",
                    backgroundColor: AppColors.whiteAccent,
                    iconData: Icons.audio_file_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            AppButton(
              onPressed: Get.back,
              backgroundColor: AppColors.redAccent,
              cornerRadius: 12,
              height: 50,
              title: "Cancel",
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: AppColors.textWhite,
              ),
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}

class OptionItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData iconData;
  final Color backgroundColor;

  const OptionItem({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.iconData,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 32,
              color: AppColors.blackAccent,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: AppColors.blackAccent,
                  height: 18 / 12),
            )
          ],
        ),
      ),
    );
  }
}
