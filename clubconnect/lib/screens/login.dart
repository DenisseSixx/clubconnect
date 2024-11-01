import 'package:clubconnect/services/notification_service.dart';
import 'package:clubconnect/ui/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:clubconnect/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/login_form_provider.dart';
import '../services/authservice.dart';
import '../ui/input_decoration.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryGreen, AppColors.azul],
            stops: [0, 1],
            begin: AlignmentDirectional(0.87, -1),
            end: AlignmentDirectional(-0.87, 1),
          ),
        ),
        alignment: const AlignmentDirectional(0, -1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                child: Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: const AlignmentDirectional(0, 0),
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
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    maxWidth: 570,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Bienvenido',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Outfit ',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                            child: Text(
                              'Complete la información a continuación para acceder a su cuenta.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ChangeNotifierProvider(
                            create: (_) => LoginFormProvider(),
                            child: _LoginForm(),
                          ) // Agregué _LoginForm como un widget
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '645',
                labelText: 'Código usuario',
                prefixIcon: Icons.wallet_membership_rounded,
              ),
              onChanged: (value) => loginForm.codUsuario = value,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              autocorrect: false,
              obscureText: _obscureText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.azulverde,
          width: 2,
        )),
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.azulverde,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                
              ),
              onChanged: (value) => loginForm.claUsuario = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          final authService =
                              Provider.of<AuthService>(context, listen: false);

                          if (!loginForm.isValidForm()) return;

                          loginForm.isLoading = true;
    try {
        // Obtener el código de dependiente
        final codDependiente = await authService.getCodDependiente(loginForm.codUsuario);

        if (codDependiente == 0) {
          // Si el código de dependiente es 0, permitir acceso directo
          final String? errorMessage = await authService.login(
            loginForm.codUsuario, loginForm.claUsuario);

          if (errorMessage == null) {
            Navigator.pushReplacementNamed(context, 'home');
          } else {
            NotificationsService.showSnackbar(errorMessage, backgroundColor: Colors.red);
            loginForm.isLoading = false;
          }
        } else {
          // Si el usuario tiene un código de dependiente diferente de 0, verificar autorización
          final autorizado = await authService.verificarAutorizacion(loginForm.codUsuario);

          if (!autorizado) {
            NotificationsService.showSnackbar('Usuario no autorizado', backgroundColor: Colors.red);
            loginForm.isLoading = false;
            return;
          }

          // Intentar iniciar sesión si el usuario está autorizado
          final String? errorMessage = await authService.login(
            loginForm.codUsuario, loginForm.claUsuario);

          if (errorMessage == null) {
            Navigator.pushReplacementNamed(context, 'home');
          } else {
            NotificationsService.showSnackbar(errorMessage, backgroundColor: Colors.red);
            loginForm.isLoading = false;
          }
        }
      } catch (e) {
        NotificationsService.showSnackbar('Error: $e', backgroundColor: Colors.red);
        loginForm.isLoading = false;
      }
    },
     style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.azul
    ),
                  child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white, fontSize: 17), ),
                ),
              ),
            ),
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
                        },
                    )
                  ],
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
