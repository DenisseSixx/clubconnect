import 'package:flutter/material.dart';

import '../ui/input_decoration.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFA7FCB8), Color(0xFFFFF4E2)],
                stops: [0, 1],
                begin: AlignmentDirectional(0.87, -1),
                end: AlignmentDirectional(-0.87, 1),
              ),
            ),
            alignment: AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                    child: Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: const Text(
                        'ClubConnect',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 34,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 570,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                                padding: EdgeInsets.all(32),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Unete',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Outfit ',
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 24),
                                        child: Text(
                                            'Complete la información a continuación para crear una cuenta.',
                                            textAlign: TextAlign.center),
                                      ),
                                      _LoginForm()
                                    ]))),
                      ))
                ]))));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            //  SizedBox(height: 32.0),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '645',
                labelText: 'Membresia',
                prefixIcon: Icons.wallet_membership_rounded,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            // SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child:
                    ElevatedButton(onPressed: null, child: Text('Registrarse')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
