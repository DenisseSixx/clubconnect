import 'package:clubconnect/models/usuarios_response.dart';
import 'package:clubconnect/services/authservice.dart';
import 'package:clubconnect/widgets/CoverImage_widget.dart';
import 'package:clubconnect/widgets/Image_widget.dart';
import 'package:clubconnect/widgets/InfoCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  Usuario? datos;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final CodUsuario =
        await Provider.of<AuthService>(context, listen: false).getUserId();
    print('UserID: $CodUsuario');
    if (CodUsuario != null) {
      final Map<String, dynamic> userData =
          await Provider.of<AuthService>(context, listen: false)
              .obtenerUsuarioPorId(CodUsuario);
      print('UserData: $userData');
      if (userData.isNotEmpty) {
        setState(() {
          datos = Usuario.fromJson(userData);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context)
              .size
              .height, // Establece la altura del contenedor como la altura de la pantalla
          child: Column(
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
              InfoCard(
                text: "Nombre   ",
                dato: '${datos?.nomUsuario ?? ""}',
                icon: Icons.supervised_user_circle,
                onPressed: () async {},
              ),
              InfoCard(
                text: "Correo  ",
                dato: '${datos?.correo ?? ""}',
                icon: Icons.email,
                onPressed: () async {},
              ),
              InfoCard(
                text: "Código  ",
                dato: '${datos?.codUsuario ?? ""}',
                icon: Icons.abc,
                onPressed: () async {},
              ),
              InfoCard(
                text: "Membresia   ",
                dato: '${datos?.codTercero ?? ""}',
                icon: Icons.verified_user_sharp,
                onPressed: () async {},
              ),
              
                InfoCard(
                text: "Administrar dependientes",
                dato: '', 
                icon: Icons.add, 
                onPressed: () {
                 Navigator.pushNamed(context, 'dependientes');
                 },
              ),
               InfoCard(
                text: "Documentos",
                dato: '', 
                icon: Icons.edit_document, 
                onPressed: () {
                 Navigator.pushNamed(context, 'documentos');
                 },
              ),
            ],
          ),
        ),
      ),
    );
  }
}