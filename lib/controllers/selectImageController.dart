import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SelectImageController extends GetxController {
  File? imageFile;
  String? pic;

  cameraImage() async {
    final _pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 400,
      maxWidth: 400,
    );
    imageFile = File(_pickedFile!.path);
    update();
  }

  galleryImage() async {
    final _pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 400,
      maxWidth: 400,
    );
    imageFile = File(_pickedFile!.path);
    update();
  }

  uploadImageToFirebase() async {
    String _fileName = basename(imageFile!.path);
    Reference _firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profilePics/$_fileName');
    UploadTask _uploadTask = _firebaseStorageRef.putFile(imageFile!);
    pic = await (await _uploadTask).ref.getDownloadURL();
  }
}
