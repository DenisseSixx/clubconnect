import 'package:flutter/material.dart';

import '../ui/utils.dart';

class AsistenciaDialogButton extends StatelessWidget {
  final String? fullname;
  final Function getDataFunction;

  AsistenciaDialogButton({
    required this.fullname,
    required this.getDataFunction,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddDialog(context);
      },
    );
  }

  void _showAddDialog(BuildContext context) {
    // ... (contenido del diálogo de agregación)
  }
}
