import 'dart:io';
import 'package:clubconnect/widgets/ImageHandler_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? imageFile;

 @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0,),
        Container(
          width: 160.0,
          height: 160.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white, // Puedes ajustar el color del marco
              width: 5.0, // Puedes ajustar el ancho del marco
            ),
          ),
          child: ClipOval(
            child: imageFile == null
                ? Image.asset('assets/no_profile_image.jpeg', height: 150.0, width: 150.0)
                : Image.file(imageFile!, height: 150.0, width: 150.0, fit: BoxFit.fill),
          ),
        ),
        const SizedBox(height: 10.0,),
        ElevatedButton(
          onPressed: () async {
            Map<Permission, PermissionStatus> statuses = await [
              Permission.storage, Permission.camera,
            ].request();
            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
              _showImagePicker(context);
            } else {
              print('no permission provided');
            }
          },
          child: Text('Cambiar foto'),
        ),
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
    ImageHandler.showImagePicker(context, _imgFromGallery, _imgFromCamera);
  }

  void _imgFromGallery() async {
    await ImageHandler.imgFromGallery((File file) {
      _cropImage(file);
    });
  }

  void _imgFromCamera() async {
    await ImageHandler.imgFromCamera((File file) {
      _cropImage(file);
    });
  }

  void _cropImage(File imgFile) async {
    await ImageHandler.cropImage(imgFile, (File croppedFile) {
      setState(() {
        imageFile = croppedFile;
      });
    });
  }
}
