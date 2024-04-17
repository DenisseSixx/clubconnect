import 'package:clubconnect/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardInfoLeading extends StatelessWidget {
  // the values we need
  final String text;
  final String dato;
  final IconData icon;
  final Function onPressed;

  CardInfoLeading({
    required this.text,
    required this.dato,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            text,
           style:GoogleFonts.roboto(
              color: AppColors.black,
              fontSize: 19,
            ),
          
          ),
          trailing: Icon(
            Icons.arrow_forward_ios, // Cambiar por el icono de flecha que desees
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
