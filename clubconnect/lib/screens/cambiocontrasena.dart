/*import 'package:flutter/material.dart';

class CambioContra extends StatelessWidget {
  const CambioContra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: TextFormField(
                              controller: Constantes.texto,
                              autocorrect: false,
                              autofocus: true,
                              obscureText: Constantes.isObscure,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                labelText: 'Contraseña',
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => Constantes.isObscure = !Constantes.isObscure),
                                  icon: Icon(Constantes.isObscure? Icons.visibility_off : Icons.visibility),
                                ),
                              ),
                              validator: (value) => value == null || value.isEmpty ? 'Campo requerido': null,
                            ),
                          ),
                          Container(height: 5),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: TextFormField(
                              controller: Constantes.textoAct,
                              autocorrect: false,
                              obscureText: Constantes.isObscureAct,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                labelText: 'Nueva contraseña',
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => Constantes.isObscureAct = !Constantes.isObscureAct),
                                  icon: Icon(Constantes.isObscureAct? Icons.visibility_off : Icons.visibility),
                                ),
                              ),
                              validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: TextFormField(
                              autocorrect: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                labelText: 'Confirmar contraseña',
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return 'Campo requerido';
                                } else if(value != Constantes.textoAct.text){
                                  return 'La contraseña de confirmación no coincide';
                                } else {
                                  return null;
                                }
                                
                              },
                            ),
                          ),
                          Container(height: 40),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                  EventosClaseUsuario(widget.eventos).ClickCambiarContrasenia(Constantes.codigoUsuario.text, Constantes.texto.text, Constantes.textoAct.text);
                              }
                            },
                            child: const Text('Cambiar Contraseña'),
                          ),
                        ],
        ),
    );
  }
}*/