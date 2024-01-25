import 'package:flutter/material.dart';
import 'package:clubconnect/widgets/widgets.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              color: Colors.black.withOpacity(0.5), // Ajusta la opacidad según tus necesidades
              child: const CoverImage(),
            ),
          const Positioned.fill(
            child: ImagePickerWidget(),
          ),
        ]
      ),
    );
  }
}
