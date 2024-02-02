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
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const CoverImage(),
              ),
              const Positioned.fill(
                child: ImagePickerWidget(),
              ),
            ],
          ),
          SizedBox(height: 20), // Espacio entre el Stack y el siguiente contenedor
          Container(
            width: 200,
            height: 100,
            color: Colors.red, // Puedes ajustar el color según tus necesidades
          ),
        ],
      ),
    );
  }
}
