import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/asistenciaservice.dart';
import '../ui/utils.dart';

//TODO: agregarle los colores
class RegistroH extends StatefulWidget {
  final String? usuario;

  const RegistroH({Key? key, this.usuario}) : super(key: key);

  @override
  State<RegistroH> createState() => _RegistroHState();
}

class _RegistroHState extends State<RegistroH> {
  String? fullname;
  String? objectid;
  List<AsistenciaService> listaAsistencia = [];

  @override
  void initState() {
    super.initState();
    fullname = widget.usuario;

    if (fullname != null) {
      _getData();
    } else {
      _getDataGeneral();
    }
  }

  Future<void> _getData() async {
    try {
      final userid = await getObjectIdByFullname(fullname!);
      if (userid != null) {
        final data = await readAsistenciasUsuario(userid);
        setState(() {
          listaAsistencia = data;
        });
      }
    } catch (e) {
      Utils.showSnackBar('Error: ${e.toString()}');
    }
  }

  Future<void> _getDataGeneral() async {
    try {
      final data = await readAsistenciasGeneral();
      setState(() {
        listaAsistencia = data;
      });
    } catch (e) {
      Utils.showSnackBar('Error: ${e.toString()}');
    }
  }

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
  
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registros'),          
        ),
        body: SingleChildScrollView(
          child: Center(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Nombre:',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                    ),
                  ),
                ),
                DataColumn(label: Text('')),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Fecha:',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                    ),
                  ),
                ),
                DataColumn(label: Text('')),
                DataColumn(label: 
                  Text(
                    'Editar',
                    style:
                      TextStyle(fontSize: 16),
                  )
                ),
                DataColumn(label:
                  Text(
                    'Borrar',
                    style:
                      TextStyle(fontSize: 16),
                  )
                )
              ],
              rows: listaAsistencia.map((asistencia) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(asistencia.fullname.toString())),
                    DataCell(Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: const Text(''),
                    )),
                    DataCell(Text(
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(asistencia.fecha.toString())),
                    )),
                    DataCell(Container(
                      margin: EdgeInsets.only(right: size.width * 0.15),
                      child: const Text(''),
                    )),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          nombreController.text =
                              asistencia.fullname.toString();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Modificar Registro'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextField(
                                      controller: nombreController,
                                      decoration: const InputDecoration(
                                          labelText: 'Nombre:'),
                                    ),
                                    TextField(
                                      controller: fechaController,
                                      decoration: const InputDecoration(
                                          labelText: 'Fecha:',
                                          icon: Icon(Icons.calendar_today)),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(
                                                    2023), 
                                                lastDate: DateTime
                                                    .now()); 
                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          setState(() {
                                            fechaController.text =
                                                formattedDate; 
                                          });
                                        } else {
                                          Utils.showSnackBar(
                                              "Date is not selected");
                                        }
                                      },
                                    ),
                                    Container(
                                      // color: Color.fromARGB(255, 128, 123, 155),
                                      height: 10,
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states){
                                          return Colors.transparent;
                                        }
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    )
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final nombre = nombreController.text;
                                      final fechaStr = fechaController.text;
                                      // final fecha = '';
                                      //     DateFormat('yyyy-MM-dd').parse(fechaStr, true);
                                      if (nombre.isNotEmpty &&
                                          fechaStr.isNotEmpty) {
                                        // Crear un objeto AsistenciaService con los nuevos datos
                                        final nuevaAsistencia =
                                            AsistenciaService(
                                          fullname: nombre,
                                          fecha: fechaStr,
                                        );
                                        await updateAsistencia(
                                            asistencia.fecha.toString(),
                                            nuevaAsistencia,
                                            asistencia.fullname.toString());
                                        nombreController.clear();
                                        fechaController.clear();
                                        Navigator.of(context).pop();
                                        if (fullname != null) {
                                          _getData();
                                        } else {
                                          _getDataGeneral();
                                        }
                                      } else {
                                        Utils.showSnackBar(
                                            "El nombre y la fecha son obligatorios");
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states){
                                          return Colors.transparent;
                                        }
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Guardar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    )
                                  ),
                                ],
                              );
                            },
                          );
                          //editar registro
                        },
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Muestra un AlertDialog para confirmar la eliminación
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmación'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        '¿Estás seguro de eliminar esta asistencia?'),
                                    const SizedBox(height: 10),
                                    Text('Nombre: ${asistencia.fullname}'),
                                    Text(
                                        'Fecha: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(asistencia.fecha.toString()))}'),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      // Cierra el AlertDialog y no realiza ninguna acción
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states){
                                          return Colors.transparent;
                                        }
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    )
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await deleteAsistencia(
                                          asistencia.fecha.toString(),
                                          asistencia.fullname.toString());

                                      if (fullname != null) {
                                        _getData();
                                      } else {
                                        _getDataGeneral();
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Asistencia eliminada con éxito'),
                                        ),
                                      );
                                      Navigator.of(context)
                                          .pop(); // Cierra el AlertDialog
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states){
                                          return Colors.transparent;
                                        }
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    )
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
              columnSpacing: size.width * 0.025,
              dividerThickness: 2,
              horizontalMargin: 5,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Agregar Registro'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: nombreController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre:',
                        ),

                        //que solo deje poner los de la base de datos y que haga busquedas que coincidan con lo que se va escribiendo?
                      ),
                      TextField(
                        controller: fechaController,
                        decoration: const InputDecoration(
                            labelText: 'Fecha:',
                            icon: Icon(Icons.calendar_today)),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2023), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime
                                  .now()); //la ultima fecha que puede escoger es la de hoy
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              fechaController.text =
                                  formattedDate; 
                            });
                          } else {
                            Utils.showSnackBar("Date is not selected");
                          }
                        },
                      ),
                      Container(
                        // color: Color.fromARGB(255, 128, 123, 155),
                        height: 10,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states){
                            return Colors.transparent;
                          }
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                      )
                    ),
                    TextButton(
                      onPressed: () async {
                        final nombre = nombreController.text;
                        final fechaStr = fechaController.text;
                        if (nombre.isNotEmpty && fechaStr.isNotEmpty) {
                          // Llamada al método addAsistenciaUsuario con nombre y fecha
                          await addAsistenciaUsuarioFecha(nombre, fechaStr);

                          // Limpiar controladores y cerrar el cuadro de diálogo
                          nombreController.clear();
                          fechaController.clear();
                          Navigator.of(context).pop();
                          if (fullname != null) {
                            _getData();
                          } else {
                            _getDataGeneral();
                          }
                        } else {
                          Utils.showSnackBar(
                              "El nombre y la fecha son obligatorios");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states){
                            return Colors.transparent;
                          }
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                      )
                    ),
                  ],
                );
              },
            );
          },
        )
        )
    );
  }
}