import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/widgets.dart';

class even extends StatelessWidget {
  const even({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clases y eventos'),),
      body:
      const CardClases()
    );
  }
}