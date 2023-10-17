
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageHandler {
  final picker = ImagePicker();

  Future<XFile?> pickImage() async {

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    print("ret file " + pickedFile!.path);

    // cropImage(pickedFile!.path).then((value) {
    //   return value;
    // });

    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   return await cropImage(pickedFile.path);
    // }

    return pickedFile;
  }

   //late final Function(File?) onImageSelected;
  Future<XFile?> cropImage(String path) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxHeight: 512,
      maxWidth: 512,
    );

    XFile xFile = XFile(croppedImage!.path);
      return xFile;

    // onImageSelected(croppedFile as File?);
  }
}