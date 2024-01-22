import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageHandler {
  static final picker = ImagePicker();

  static void showImagePicker(BuildContext context, VoidCallback galleryCallback, VoidCallback cameraCallback) {
    showModalBottomSheet(
      context: context,
      builder: (builder){
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/5.2,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: const [
                        Icon(Icons.image, size: 60.0,),
                        SizedBox(height: 12.0),
                        Text(
                          "Galeria",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )
                      ],
                    ),
                    onTap: () {
                      galleryCallback();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: SizedBox(
                      child: Column(
                        children: const [
                          Icon(Icons.camera_alt, size: 60.0,),
                          SizedBox(height: 12.0),
                          Text(
                            "Camara",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      cameraCallback();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> imgFromGallery(Function(File) callback) async {
    await picker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        callback(File(value.path));
      }
    });
  }

  static Future<void> imgFromCamera(Function(File) callback) async {
    await picker.pickImage(
      source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        callback(File(value.path));
      }
    });
  }

  static Future<void> cropImage(File imgFile, Function(File) callback) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ] : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [AndroidUiSettings(
        toolbarTitle: "Recortar foto",
        toolbarColor: Colors.greenAccent,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
        IOSUiSettings(
          title: "Recortar foto",
        )
      ],
    );
    if (croppedFile != null) {
      imageCache.clear();
      callback(File(croppedFile.path));
    }
  }
}
