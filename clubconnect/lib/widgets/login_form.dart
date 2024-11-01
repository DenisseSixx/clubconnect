/*import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_form_provider.dart';
import '../ui/input_decoration.dart';

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       final loginForm = Provider.of<LoginFormProvider>(context);
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
            const SizedBox(height: 10.0),
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
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'home');
                    },
                    child: const Text('Iniciar Sesión')),
              ),
            ),

            // ElevatedButton(onPressed: Navigator.push(context, MaterialPageRoute(builder: (context)=> const homepage())), child: Text('Iniciar Sesion'))],
            //  SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
              child: RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: '¿No tienes una cuenta? ',
                      style: TextStyle(),
                    ),
                    TextSpan(
                        text: 'Registrate',
                        style: const TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                           

                            Navigator.pushNamed(context, 'registro');
                          })
                  ],
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
            //Column(children: [Text('¿No tienes una cuenta?'), TextButton(onPressed: null, child: Text('Registrarse'))],)
          ],
        ),
      ),
    );
  }
}*/