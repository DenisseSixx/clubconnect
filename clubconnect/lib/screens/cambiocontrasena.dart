import 'package:clubconnect/ui/colors.dart';
import 'package:clubconnect/widgets/GradientScaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clubconnect/models/usuarios_response.dart';
import 'package:clubconnect/services/authservice.dart';

class CambioContra extends StatefulWidget {
  const CambioContra({Key? key}) : super(key: key);

  @override
  _CambioContraState createState() => _CambioContraState();
}

class _CambioContraState extends State<CambioContra> {
  bool _obscureText = true;
  bool _obscureTextNewPassword = true;
  late TextEditingController _contrasenaController;
  late TextEditingController _nuevaContrasenaController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nuevaContrasenaController = TextEditingController();
    _contrasenaController = TextEditingController();
  }

  @override
  void dispose() {
    _nuevaContrasenaController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      leading: const Icon(Icons.arrow_back),
      leadingCallback: () {
        Navigator.of(context).pop();
      },
      body: Container(
        child: Column(
          children: [
            //
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Form(
                  // padding: const EdgeInsets.all(20.0),
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      const Text(
                        'Cambiar contraseña',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      
                      Container(
                         padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          controller: _contrasenaController,
                          autocorrect: false,
                          autofocus: true,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: 'Contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Campo requerido'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                         padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          controller: _nuevaContrasenaController,
                          autocorrect: false,
                          obscureText: _obscureTextNewPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: 'Nueva contraseña',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureTextNewPassword =
                                      !_obscureTextNewPassword;
                                });
                              },
                              icon: Icon(
                                _obscureTextNewPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Campo requerido'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                         padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: 'Confirmar contraseña',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo requerido';
                            } else if (value !=
                                _nuevaContrasenaController.text) {
                              return 'La contraseña de confirmación no coincide';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final claUsuario = _nuevaContrasenaController.text;
                            final codUsuario = await Provider.of<AuthService>(
                                    context,
                                    listen: false)
                                .getUserId();
                            if (codUsuario != null) {
                              await Provider.of<AuthService>(context,
                                      listen: false)
                                  .CambiarContrasena(codUsuario, claUsuario);
                            } else {
                              // Manejar el caso cuando el codUsuario es nulo
                            }
                          } 
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          minimumSize: const Size(100, 50),
                        ),
                        child: const Text(
                          'Cambiar Contraseña',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
