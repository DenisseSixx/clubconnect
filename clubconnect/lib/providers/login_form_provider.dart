import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String codUsuario = '';
  String claUsuario= '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    print(_isLoading);
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    print('$codUsuario - $claUsuario');

    return formKey.currentState?.validate() ?? false;
  }
}