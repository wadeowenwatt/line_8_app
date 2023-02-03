import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../models/entities/user/my_user_entity.dart';

class FileMessage extends StatelessWidget {
  final ChatMessageEntity message;
  final MyUserEntity currentUser;

  const FileMessage(
      {Key? key, required this.message, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOwnMessage = message.authorId == currentUser.uid;
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onOpenFile,
      child: Container(
        decoration: BoxDecoration(
          color: isOwnMessage ? AppColors.orangeAccent : AppColors.greyAccent,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: isOwnMessage ? const Radius.circular(8) : Radius.zero,
            bottomRight: isOwnMessage ? Radius.zero : const Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.file_present_outlined,
              size: 32,
              color: Colors.white,
            ),
            const SizedBox(
              width: 12,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.5),
              child: Text(
                message.meta?["fileName"],
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: isOwnMessage
                        ? AppColors.whiteAccent
                        : AppColors.blackAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onOpenFile() async {
    Get.to(() => PDFViewerPage(url: message.meta?["url"] ?? ""));
  }
}

class PDFViewerPage extends StatelessWidget {
  final String url;

  const PDFViewerPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SfPdfViewer.network(url),
        ),
      ),
    );
  }
}
