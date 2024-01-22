import 'package:flutter/material.dart';
import '../widgets/CoverImage_widget.dart';
import '../widgets/ImageHandler_widget.dart';
import '../widgets/Image_widget.dart';
import 'package:clubconnect/widgets/widgets.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              color: Colors.black.withOpacity(0.5), // Ajusta la opacidad según tus necesidades
              child: CoverImage(),
            ),
          Positioned.fill(
            child: ImagePickerWidget(),
          ),
        ]
      ),
    );
  }
}
