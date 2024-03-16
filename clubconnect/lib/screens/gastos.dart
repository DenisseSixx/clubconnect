import 'package:clubconnect/models/estadocuenta_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clubconnect/models/usuarios_response.dart';
import 'package:clubconnect/services/authservice.dart';

class gastos extends StatefulWidget {
  const gastos({Key? key}) : super(key: key);

  @override
   _GastosState createState() => _GastosState();

 

}

class _GastosState extends State<gastos> {
EstadoCuenta1? estadoCuenta1;

    @override
  void initState() {
    super.initState();
    cargarEstado();
  }
  Future<void> cargarEstado() async {
    final CodUsuario =
        await Provider.of<AuthService>(context, listen: false).getUserId();
    print('UserID: $CodUsuario');
    if (CodUsuario != null) {
      final List<Map<String, dynamic>> userEstado =
          await Provider.of<AuthService>(context, listen: false)
              .ObtenerEstadoCuenta(CodUsuario);
      print('UserEstado: $userEstado');
      if (userEstado.isNotEmpty) {
        List<EstadoCuenta1> listaEstado = [];
        userEstado.forEach((map) {
          listaEstado.add(EstadoCuenta1.fromJson(map));
        });
        setState(() {
          estadoCuenta1 = listaEstado as EstadoCuenta1?;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumos y gastos'),
      ),
     /* body: FutureBuilder<Usuario?>(
       ,
        builder: (BuildContext context, AsyncSnapshot<Usuario?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final Usuario? usuario = snapshot.data;
              if (usuario != null) {
                return Center(
                  child: Text('Bienvenido, ${usuario.nombre}'),
                );
              } else {
                return Center(
                  child: Text('No se pudo cargar el usuario'),
                );
              }
            }
          }
        },
      ),*/
    );
  }
}
