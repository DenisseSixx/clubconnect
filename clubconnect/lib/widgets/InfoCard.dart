import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final String dato;
  final IconData icon;
  final Function onPressed;

  InfoCard({
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
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.teal,
              fontSize: 20,
              fontFamily: "Source Sans Pro",
            ),
          ),
          subtitle: Text(
            dato,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: "Source Sans Pro",
            ),
          ),
        ),
      ),
    );
  }
}
