import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{
  final String _UrlBase = '10.0.0.17:5272';

  final storage = new FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUser( String CodTercero, String CodDependiente, String CodUsuario, String NomUsuario, String ClaUsuario,String Nombre, String CodEstusu) async {
    final Map<String, dynamic> authData = {
      'codTercero' : CodTercero,
      "codDependiente": CodDependiente,
     'codUsuario': CodUsuario,
  "nomUsuario": NomUsuario,
  'claUsuario': ClaUsuario,
  "nombre": Nombre,
  "codEstusu": CodEstusu
        
      
      //'returnSecureToken': true
    };

    final url = Uri.http(_UrlBase, '/api/Appusuarios/CrearUsuario');

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['token']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String CodUsuario, String ClaUsuario) async {
    final Map<String, dynamic> authData = {
       'codUsuario': CodUsuario,
      'claUsuario': ClaUsuario,
    };
    final url = Uri.http(_UrlBase, '/api/Appusuarios/Login');

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData));
    print(resp.statusCode);

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      // Token hay que guardarlo en un lugar seguro
      // decodedResp['idToken'];
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }


}