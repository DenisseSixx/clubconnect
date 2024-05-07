import 'package:clubconnect/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Documentos extends StatefulWidget {
  const Documentos({super.key});

  @override
  State<Documentos> createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.primaryGreen, AppColors.azul])
          )
        ),
        title: Text(
          'Documentos',
          style: GoogleFonts.barlowCondensed(
            textStyle: const TextStyle(fontSize: 24, color: Colors.white),
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
      );
  }
}