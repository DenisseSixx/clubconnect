import 'package:clubconnect/widgets/CardInfoLeading.dart';
import 'package:flutter/material.dart';
import 'package:clubconnect/widgets/InfoCard.dart'; // Importa el widget InfoCard

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: Container(
        child: CardInfoLeading(
          text: 'Cambiar contraseña',
          dato: '', // Coloca tu dato aquí
          icon: Icons.privacy_tip, // Cambia el icono según tu preferencia
          onPressed: () {
            Navigator.pushNamed(context, 'cambiocontra');
          },
        ),
      ),
    );
  }
}
