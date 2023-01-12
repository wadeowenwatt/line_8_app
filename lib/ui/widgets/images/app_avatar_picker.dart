import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppAvatarPickerWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClicked;

  const AppAvatarPickerWidget({
    Key? key,
    required this.image,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(context),
          // Positioned(
          //   bottom: 0,
          //   right: 4,
          //   child: buildEditIcon(),
          // )
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    final imagePath = this.image.path;
    final image = imagePath.contains("https://")
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
            image: image as ImageProvider,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
            child: InkWell(
              onTap: () async {
                final source = await showImageSource(context);
                if (source == null) return;

                onClicked(source);
              },
            )),
      ),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Gallery"),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }
}
