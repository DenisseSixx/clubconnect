import 'package:clubconnect/ui/colors.dart';
import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final Widget? leading;
  final Function()? leadingCallback;

  const GradientScaffold({
    Key? key,
    required this.body,
    this.leading,
    this.leadingCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryGreen, AppColors.azul],
          ),
        ),
        child: Stack(
          children: [
            if (leading != null)
              Positioned(
                top: 30,
                left: 10,
                child: GestureDetector(
                  onTap: leadingCallback,
                  child: leading!,
                ),
              ),
            body,
          ],
        ),
      ),
    );
  }
}