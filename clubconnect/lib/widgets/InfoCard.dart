import 'package:clubconnect/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final String dato;
  final IconData icon;
  

  InfoCard({
    required this.text,
    required this.dato,
    required this.icon,
  
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    
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
          subtitle: Text(
            dato,
            style:GoogleFonts.roboto(
              color: AppColors.plomo,
              fontSize: 17,
             
            ),
          ),
        ),
      ),
    );
  }
}
