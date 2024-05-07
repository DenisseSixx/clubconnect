import 'package:clubconnect/ui/colors.dart';
import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.azulverde,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.azulverde,
          width: 2,
        )),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.azulverde,
              )
            : null);
            
  }

}