import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/app/core/utils/components/app_components.dart';

Future<File?> pickImageFromGallery() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    AppComponents.showCustomSnackBar(e.toString());
  }
  return image;
}

Future<File?> pickImageFromCamera() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    AppComponents.showCustomSnackBar(e.toString());
  }
  return image;
}

Future<File?> pickVideoFromGallery() async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    AppComponents.showCustomSnackBar(e.toString());
  }
  return video;
}

Future<File?> pickVideoFromCamera() async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.camera);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    AppComponents.showCustomSnackBar(e.toString());
  }
  return video;
}

Future<List<File>> pickImagesFromGallery() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
