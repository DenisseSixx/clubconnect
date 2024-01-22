import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);
  final double coverHeight = 280;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: coverHeight,
      color: Colors.black.withOpacity(0.5), // Ajusta la opacidad según tus necesidades
      child: Image.asset(
        'assets/cover.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
