import 'package:flutter/material.dart';

class NotificationsService {

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackbar(String? text, {Color? backgroundColor, IconData? icon}) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          SizedBox(width: icon != null ? 10 : 0),
          Text(text),
        ],
      ),
      backgroundColor: backgroundColor ?? Colors.grey[800],
      behavior: SnackBarBehavior.floating,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
      }

  /*static showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      duration: Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }*/
}
