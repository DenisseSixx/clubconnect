import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:clubconnect/models/estadocuenta_response.dart';
import 'package:clubconnect/services/authservice.dart';

class Gastos extends StatelessWidget {
  const Gastos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inicializar los símbolos de fecha en español
    initializeDateFormatting('es', null);

    return Scaffold(
  appBar: AppBar(
    title: Text(
      'CONSUMOS Y GASTOS',
      style: GoogleFonts.barlowCondensed(
        textStyle: const TextStyle(fontSize: 24), 
      ),
    ),
       backgroundColor: Colors.cyan[100],
    elevation: 4, // Establece la elevación para agregar sombra
    shadowColor: Colors.blueGrey, // Establece el color de la sombra
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(15), // Establece la forma de la parte inferior del AppBar
      ),
    ),
  ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment. center,
        children: [
           const SizedBox(height: 20), 
          const Text(
            'Estado de Cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: FutureBuilder<List<EstadoCuenta1>>(
              future: cargarEstado(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<EstadoCuenta1>? estadoCuentaList = snapshot.data;
                  if (estadoCuentaList != null && estadoCuentaList.isNotEmpty) {
                    final totales = calcularTotales(estadoCuentaList);
                    // Organizar la lista por fecha
                    estadoCuentaList.sort((a, b) => a.codPeriodo.compareTo(b.codPeriodo));

                    // Crear un mapa para agrupar elementos por fecha
                    final Map<DateTime, List<EstadoCuenta1>> groupedByDate = {};
                    estadoCuentaList.forEach((estado) {
                      final fecha = DateTime(estado.codPeriodo.year, estado.codPeriodo.month, estado.codPeriodo.day);
                      if (!groupedByDate.containsKey(fecha)) {
                        groupedByDate[fecha] = [];
                      }
                      groupedByDate[fecha]!.add(estado);
                    });
                   return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Adeudos Anteriores: ', style: TextStyle(fontSize: 16)),
                                  Text(totales[0].toStringAsFixed(2), style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('- Abonos: ', style: TextStyle(fontSize: 16)),
                                  Text(totales[1].toStringAsFixed(2), style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('- Bonificación: ', style: TextStyle(fontSize: 16)),
                                  Text(totales[2].toStringAsFixed(2), style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('- Descuentos: ', style: TextStyle(fontSize: 16)),
                                  Text(totales[3].toStringAsFixed(2), style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('+ IVA: ', style: TextStyle(fontSize: 16)),
                                  Text(totales[4].toStringAsFixed(2), style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('- Monto a favor: ', style: TextStyle(fontSize: 16)),
                                  Text(totales[5].toStringAsFixed(2), style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                                 Container(
                                   color: Colors.cyan[100],
                                child:   Column(
                              children: [
       const SizedBox(
        height: 3, // Altura del Divider personalizada
        child: Divider(
          color: Colors.blueGrey, // Color del Divider
          thickness: 1, // Grosor del Divider
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            totales[6].toStringAsFixed(2),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
          const SizedBox(
        height: 5, // Altura del Divider personalizada
        child: Divider(
          color: Colors.blueGrey, // Color del Divider
          thickness: 1, // Grosor del Divider
        ),)
                             ] ),
 
                           ) ],
),
                            
Expanded(
  child: Container(
    color: const Color.fromARGB(255, 236, 253, 255),// Establecer el color de fondo del contenedor como cyan
    child: ListView.builder(
      itemCount: groupedByDate.length,
      itemBuilder: (context, index) {
        final fecha = groupedByDate.keys.toList()[index];
        final listaEstado = groupedByDate[fecha]!;
        final fechaEnLetras = _obtenerFechaEnLetras(fecha);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              child: Text(
                fechaEnLetras,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listaEstado.length,
              itemBuilder: (context, index) {
                final EstadoCuenta1 estadoCuenta1 = listaEstado[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.zero, // Reducir el espacio vertical entre elementos de la lista
                      child: ListTile(
                       contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0), // Ajustar el espacio alrededor del contenido del ListTile
                        dense: true, // Ajustar el espacio alrededor del contenido del ListTile
                        title: Text(estadoCuenta1.titulo),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descripción: ${estadoCuenta1.desImporte}',style: const TextStyle(fontSize: 15)),
                            Text('Saldo: ${estadoCuenta1.montoOriginal}',style: const TextStyle(fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                 
                  ],
                );
              },
            ),
            if (index < groupedByDate.length - 1) // Añadir un separador después de cada mes, excepto el último
              const Divider(),
                                  ],
                                );
                              },
                            ),
                          ),
),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('No se encontraron datos de estado de cuenta'));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<EstadoCuenta1>> cargarEstado(BuildContext context) async {
    final CodUsuario =
        await Provider.of<AuthService>(context, listen: false).getUserId();
   // print('UserID: $CodUsuario');
    if (CodUsuario != null) {
      final List<Map<String, dynamic>> userEstado =
          await Provider.of<AuthService>(context, listen: false)
              .ObtenerEstadoCuenta(CodUsuario);
     // print('UserEstado: $userEstado');
      if (userEstado.isNotEmpty) {
        List<EstadoCuenta1> listaEstado = [];
        userEstado.forEach((map) {
          final estadoCuenta = EstadoCuenta1.fromJson(map);
          if (estadoCuenta.codImporte != 0 &&
              estadoCuenta.codTipo.isNotEmpty &&
              estadoCuenta.codSubtipo.isNotEmpty &&
              estadoCuenta.desImporte.isNotEmpty) {
            listaEstado.add(estadoCuenta);
          }
        });
        return listaEstado;
      }
    }
    // Si no hay datos, devuelve una lista vacía
    return [];
  }

  // Función para obtener la fecha en letras a partir del código de periodo
  String _obtenerFechaEnLetras(DateTime fecha) {
    final mes = DateFormat.MMMM('es').format(fecha); // Obtiene el nombre del mes en letras
    final a = DateFormat.y().format(fecha); // Obtiene el año en letras
    return '$mes del $a';
  }

  List<double> calcularTotales(List<EstadoCuenta1> estadoCuentaList) {
    double sumaAdeudosAnteriores = 0;
    double sumaAbonos = 0;
    double sumaBonificacion = 0;
    double sumaDescuentos = 0;
    double sumaIva= 0;
    double sumaMonfoFavor = 0;


    // Iterar sobre todos los elementos de estado de cuenta para calcular los totales
    estadoCuentaList.forEach((estado) {
      sumaAdeudosAnteriores += estado.montoOriginal;
      sumaAbonos += estado.monAbono;
      sumaBonificacion += estado.bonificacion;
      sumaDescuentos += estado.montoDescuento;
      sumaIva += estado.monIvaAdeudo;
      sumaMonfoFavor += estado.aFavorAplicado;
    });

    // Calcular el total
    final total = sumaAdeudosAnteriores - sumaAbonos - sumaBonificacion - sumaDescuentos + sumaIva - sumaMonfoFavor;

    return [sumaAdeudosAnteriores, sumaAbonos, sumaBonificacion, sumaDescuentos, sumaIva, sumaMonfoFavor, total];
  }
}
