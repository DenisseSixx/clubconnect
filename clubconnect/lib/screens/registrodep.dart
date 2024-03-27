import 'package:clubconnect/models/autorizacion_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:clubconnect/models/dependientes_response.dart';
import 'package:clubconnect/services/authservice.dart';

class RegistroDep extends StatefulWidget {
  const RegistroDep({Key? key}) : super(key: key);

  @override
  _RegistroDepState createState() => _RegistroDepState();
}

class _RegistroDepState extends State<RegistroDep> {
  List<SaDependiente> _dependientes = [];
  Map<double, bool> _selectedDependientes = {};
  List<Appautorizaciond> _estados = [];

  @override
  void initState() {
    super.initState();
    cargarEstadoDependientes(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dependientes',
          style: GoogleFonts.barlowCondensed(
            textStyle: const TextStyle(fontSize: 24),
          ),
        ),
        backgroundColor: Colors.cyan[100],
        elevation: 4,
        shadowColor: Colors.blueGrey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: FutureBuilder<List<SaDependiente>>(
        future: cargarDependientes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _dependientes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: _dependientes.length,
              itemBuilder: (context, index) {
                final SaDependiente dependiente = _dependientes[index];
                final isChecked = _selectedDependientes[dependiente.codDependiente] ?? false;
                final edad = _calcularEdad(dependiente.fecNacimiento);
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dependiente.nombre,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Codigo dependiente: ${dependiente.codDependiente}'),
                            const SizedBox(height: 4),
                            Text('Edad: $edad años'),
                            const SizedBox(height: 4),
                            if (dependiente.codCredencial != null &&
                                dependiente.codCredencial.isNotEmpty)
                              Text(
                                  'Número telefónico: ${dependiente.codCredencial}'),
                            const SizedBox(height: 4),
                            Text(
                                'Límite de crédito: ${dependiente.limiteCredito}'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (value) async {
                            setState(() {
                              _selectedDependientes[dependiente.codDependiente.toDouble()] = value ?? false;
                            });
                            final codTercero = dependiente.codTercero;
                            final codDependiente = dependiente.codDependiente;
                            final codAutorizacion = value ?? false;
                            await Provider.of<AuthService>(context, listen: false)
                                .updateAppautorizaciond(codTercero, codDependiente, codAutorizacion);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String _calcularEdad(DateTime fechaNacimiento) {
    final today = DateTime.now();
    final age = today.year - fechaNacimiento.year;
    if (today.month < fechaNacimiento.month ||
        (today.month == fechaNacimiento.month &&
            today.day < fechaNacimiento.day)) {
      return (age - 1).toString();
    }
    return age.toString();
  }

  Future<List<SaDependiente>> cargarDependientes(BuildContext context) async {
    final CodUsuario =
        await Provider.of<AuthService>(context, listen: false).getUserId();
    //print('UserID: $CodUsuario');
    if (CodUsuario != null) {
      final List<Map<String, dynamic>> userDepen =
          await Provider.of<AuthService>(context, listen: false)
              .obtenerDependientes(CodUsuario);
     // print('UserData: $userDepen');

      List<SaDependiente> dependientes = [];
      userDepen.forEach((map) {
        SaDependiente dependiente = SaDependiente.fromJson(map);
        dependientes.add(dependiente);
      });

      return dependientes;
    }
    return [];
  }
Future<void> cargarEstadoDependientes(BuildContext context) async {
  final CodUsuario = await Provider.of<AuthService>(context, listen: false).getUserId();
  if (CodUsuario != null) {
    final codTercero = await Provider.of<AuthService>(context, listen: false).getCodTercero(CodUsuario);
    if (codTercero != null) {
      final codTerceroString = codTercero.toString(); // Convertir el entero a cadena
      final autorizaciones = await  Provider.of<AuthService>(context, listen: false).obtenerAutorizaciones(codTerceroString); // Llama al servicio para obtener autorizaciones
      setState(() {
        _estados = autorizaciones;
        // Actualizar los checkboxes marcados según los estados de autorización
      _selectedDependientes = Map.fromIterable(
  _dependientes,
  key: (dependiente) => dependiente.codDependiente.toDouble(), // Convertir a double
  value: (dependiente) {
    final autorizacion = autorizaciones.firstWhere(
      (aut) => aut.codDependiente == dependiente.codDependiente,
      orElse: () => Appautorizaciond.withCodTercero(codTerceroString),
    );
    return autorizacion.codAutorizacion ?? false;
  },
);
      });
    }
  }
}
}


