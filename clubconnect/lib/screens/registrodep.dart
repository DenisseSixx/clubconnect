import 'package:clubconnect/models/dependientes_response.dart';
import 'package:clubconnect/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistroDep extends StatelessWidget {
  const RegistroDep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de dependientes"),
      ),
      body: FutureBuilder<List<SaDependiente>>(
        future: cargarDependientes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<SaDependiente>? dependientes = snapshot.data;
            if (dependientes != null && dependientes.isNotEmpty) {
              return ListView.builder(
                itemCount: dependientes.length,
                itemBuilder: (context, index) {
                  final SaDependiente dependiente = dependientes[index];
                  return ListTile(
                    title: Text(dependiente.nombre), // Mostrar el nombre del dependiente
                    // Aquí puedes mostrar más información sobre el dependiente si es necesario
                  );
                },
              );
            } else {
              return Center(child: Text('No se encontraron dependientes'));
            }
          }
        },
      ),
    );
  }

 Future<List<SaDependiente>> cargarDependientes(BuildContext context) async {
    final CodUsuario =
        await Provider.of<AuthService>(context, listen: false).getUserId();
    print('UserID: $CodUsuario');
    if (CodUsuario != null) {
      final List<Map<String, dynamic>> userData =
          await Provider.of<AuthService>(context, listen: false)
              .obtenerDependientes(CodUsuario);
      print('UserData: $userData');
      List<SaDependiente> dependientes = [];
      userData.forEach((map) {
        SaDependiente dependiente = SaDependiente.fromJson(map);
        dependientes.add(dependiente);
      });
      return dependientes;
    }
    return []; // Si no se encontraron dependientes, devolver una lista vacía
  }
}