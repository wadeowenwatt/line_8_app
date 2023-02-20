import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/models/enums/message_type.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../models/entities/user/my_user_entity.dart';

class ChatInput extends StatelessWidget {
  final Function(ChatMessageEntity) onSend;
  final MyUserEntity currentUser;

  ChatInput({super.key, required this.onSend, required this.currentUser});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minHeight: 72, maxHeight: size.height * 0.12),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 12,
      ),
      child: SizedBox(
        height: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => onTapOptions(context),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(maxHeight: 72),
                padding: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(
                  AppImages.icAdd,
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: _controller,
                onFieldSubmitted: _onSendTextMessage,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackAccent,
                ),
                maxLines: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE3E3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  // prefixIcon: Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: SvgPicture.asset(
                  //     AppImages.icSmile,
                  //     width: 16,
                  //     height: 16,
                  //   ),
                  // ),
                  suffixIcon: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () => _onSendTextMessage(_controller.text),
                      child: SvgPicture.asset(
                        AppImages.icSend,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(
                      left: 4, right: 4, top: 4, bottom: 4),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 16,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSendTextMessage(String text) {
    if (text.isNotEmpty) {
      final ChatMessageEntity message = ChatMessageEntity(
        authorId: currentUser.uid,
        text: text,
        type: MessageType.text,
      );
      onSend(message);
      _controller.text = "";
    }
  }

  Future<void> _onSendAudioMessage() async {
    final storageRef = FirebaseStorage.instance.ref();
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final fileRef = storageRef.child("/audio/${result.files.single.name}");
      try {
        AppDialog.showLoadingDialog();
        await fileRef.putFile(file);
        final url = await fileRef.getDownloadURL();
        final ChatMessageEntity audioMessage = ChatMessageEntity(
          authorId: currentUser.uid,
          type: MessageType.audio,
          meta: {
            "url": url,
          },
        );
        onSend(audioMessage);
      } on FirebaseException catch (e) {
        logger.e(e);
      } finally {
        Get.back();
      }
    } else {
      // User canceled the picker
    }
  }

  Future<void> _onSendImageMessage() async {
    final storageRef = FirebaseStorage.instance.ref();
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final fileRef = storageRef.child("/images/${result.files.single.name}");
      try {
        AppDialog.showLoadingDialog();
        await fileRef.putFile(file);
        final url = await fileRef.getDownloadURL();
        final ChatMessageEntity imageMessage = ChatMessageEntity(
          authorId: currentUser.uid,
          type: MessageType.image,
          meta: {
            "url": url,
          },
        );
        onSend(imageMessage);
      } on FirebaseException catch (e) {
        logger.e(e);
      } finally {
        Get.back();
      }
    } else {
      // User canceled the picker
    }
  }

  Future<void> _onSendVideoMessage(BuildContext context) async {
    final storageRef = FirebaseStorage.instance.ref();
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final fileRef = storageRef.child("/videos/${result.files.single.name}");

      try {
        AppDialog.showLoadingDialog();
        await fileRef.putFile(file);
        final url = await fileRef.getDownloadURL();
        final thumbnailPath = await VideoThumbnail.thumbnailFile(
          video: file.path,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 128,
          quality: 100,
        );

        final thumbnailRef =
            storageRef.child("/images/${thumbnailPath?.split("/").last}");
        File thumbnailFile = File(thumbnailPath!);
        thumbnailRef.putFile(thumbnailFile);
        final thumbnailUrl = await thumbnailRef.getDownloadURL();
        final ChatMessageEntity videoMessage = ChatMessageEntity(
          authorId: currentUser.uid,
          type: MessageType.video,
          meta: {"url": url, "thumbnailUrl": thumbnailUrl},
        );
        onSend(videoMessage);
      } on FirebaseException catch (e) {
        logger.e(e);
      } finally {
        Get.back();
      }
    } else {
      // User canceled the picker
    }
  }

  Future<void> _onSendFileMessage() async {
    final storageRef = FirebaseStorage.instance.ref();
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final fileRef = storageRef.child("/files/${result.files.single.name}");
      try {
        AppDialog.showLoadingDialog();
        await fileRef.putFile(file);
        final url = await fileRef.getDownloadURL();
        final ChatMessageEntity fileMessage = ChatMessageEntity(
          authorId: currentUser.uid,
          type: MessageType.file,
          meta: {"url": url, "fileName": result.files.single.name},
        );
        onSend(fileMessage);
      } on FirebaseException catch (e) {
        logger.e(e);
      } finally {
        Get.back();
      }
    } else {
      // User canceled the picker
    }
  }

  void onTapOptions(BuildContext context) {
    _hideKeyboard(context);

    AppDialog.showPickOptions(
      onPressed: (messageType) async {
        if (messageType == MessageType.audio) {
          await _onSendAudioMessage();
          Get.back();
        } else if (messageType == MessageType.image) {
          await _onSendImageMessage();
          Get.back();
        } else if (messageType == MessageType.video) {
          await _onSendVideoMessage(context);
          Get.back();
        } else if (messageType == MessageType.file) {
          await _onSendFileMessage();
          Get.back();
        }
      },
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
