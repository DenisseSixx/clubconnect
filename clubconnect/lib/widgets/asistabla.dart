import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/asistenciaservice.dart';
import '../ui/utils.dart';

class AsistenciaDataTable extends StatelessWidget {
  final List<AsistenciaService> listaAsistencia;
  final Size size;
  final TextEditingController nombreController;
  final TextEditingController fechaController;
  final Function getDataFunction;

  AsistenciaDataTable({
    required this.listaAsistencia,
    required this.size,
    required this.nombreController,
    required this.fechaController,
    required this.getDataFunction,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Nombre:',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ),
        ),
        DataColumn(label: Text('')),
        DataColumn(
          label: Expanded(
            child: Text(
              'Fecha:',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ),
        ),
        DataColumn(label: Text('')),
        DataColumn(
          label: Text(
            'Editar',
            style: TextStyle(fontSize: 16),
          ),
        ),
        DataColumn(
          label: Text(
            'Borrar',
            style: TextStyle(fontSize: 16),
          ),
        ),
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
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(asistencia.fecha.toString()),
              ),
            )),
            DataCell(Container(
              margin: EdgeInsets.only(right: size.width * 0.15),
              child: const Text(''),
            )),
            DataCell(
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  nombreController.text = asistencia.fullname.toString();
                  _showEditDialog(context, asistencia);
                },
              ),
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _showDeleteConfirmation(context, asistencia);
                },
              ),
            ),
          ],
        );
      }).toList(),
      columnSpacing: size.width * 0.025,
      dividerThickness: 2,
      horizontalMargin: 5,
    );
  }

  void _showEditDialog(BuildContext context, AsistenciaService asistencia) {
    // ... (contenido del diálogo de edición)
  }

  void _showDeleteConfirmation(BuildContext context, AsistenciaService asistencia) {
    // ... (contenido del diálogo de confirmación de eliminación)
  }
}
