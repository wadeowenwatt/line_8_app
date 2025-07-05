import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class FireStorageRepository {
  Future<String?> uploadImage(XFile? image);
}

class FireStorageRepositoryImpl extends FireStorageRepository {

  @override
  Future<String?> uploadImage(XFile? image) async {
    String? urlAvatar;
    File fileImage = File(image!.path);
    final storageRef = FirebaseStorage.instance.ref();

    Reference avatarRef = storageRef.child("/avatars/${image.name}");
    try {
      await avatarRef.putFile(fileImage);
      final url = await avatarRef.getDownloadURL();
      urlAvatar = url;
    } catch (error) {
      print(error);
    }
    return urlAvatar;
  }
}
