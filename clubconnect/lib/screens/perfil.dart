import 'package:flutter/material.dart';
import '../widgets/ImageHandler_widget.dart';
import '../widgets/Image_widget.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi perfil'),
      ),
     body: Center(
        child: ImagePickerWidget(
          
        ),
      ),
    );
  }
}
