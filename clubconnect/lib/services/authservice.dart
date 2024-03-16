import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _UrlBase = '10.0.0.15:5272';

  final storage = new FlutterSecureStorage();

  Future<String?> createUser(
      String CodTercero,
      String CodDependiente,
      String CodUsuario,
      String NomUsuario,
      String ClaUsuario,
      String Nombre,
      String CodEstusu) async {
    final Map<String, dynamic> authData = {
      'codTercero': CodTercero,
      "codDependiente": CodDependiente,
      'codUsuario': CodUsuario,
      "nomUsuario": NomUsuario,
      'claUsuario': ClaUsuario,
      "nombre": Nombre,
      "codEstusu": CodEstusu
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

  Future<String?> getUserId() async {
    try {
      final token = await readToken();

      if (token != null) {
        print('Decoded Token: $token');
        // Decodificar el token para obtener la información del usuario
        final Map<String, dynamic> decodedToken = json.decode(
          ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))),
        );
        if (decodedToken.containsKey('CodUsuario')) {
          print('CodUsuario: ${decodedToken['CodUsuario']}');
          return decodedToken['CodUsuario'];
        }
      }
    } catch (e) {
      print('Error al obtener el ID del usuario: $e');
    }

    return null;
  }

  Future<Map<String, dynamic>> obtenerUsuarioPorId(String codUsuario) async {
    try {
      final url =
          Uri.http(_UrlBase, 'api/Appusuarios/ObtenerPorID/$codUsuario');
      final resp = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (resp.statusCode == 200) {
        final dynamic data = json.decode(resp.body);

        // Verificar si el resultado es un mapa
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          // Si no es un mapa, puedes manejar el caso según tu lógica
          print('Error: La respuesta no es un objeto');
          return {};
        }
      } else {
        print(
            'Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
        return {};
      }
    } catch (error) {
      print('Excepción al obtener datos del usuario: $error');
      return {};
    }
  }

 Future<List<Map<String, dynamic>>> ObtenerEstadoCuenta(String codUsuario) async {
  try {
    final url = Uri.http(_UrlBase, 'api/Cuentas/ObtenerEstadoCuenta/$codUsuario');
    final resp = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (resp.statusCode == 200) {
      final dynamic data = json.decode(resp.body);

      if (data is List<dynamic>) {
        // Si la respuesta es una lista de objetos, puedes devolverla directamente
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Error: La respuesta no es una lista de objetos');
        return []; // Devuelve una lista vacía en caso de un formato de respuesta incorrecto
      }
    } else {
      print('Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
      // En caso de error, puedes lanzar una excepción para manejarla más adelante
      throw Exception('Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
    }
  } catch (error) {
    print('Excepción al obtener datos del usuario: $error');
    // En caso de excepción, puedes lanzarla para manejarla más adelante
    throw Exception('Excepción al obtener datos del usuario: $error');
  }
}

  Future<List<Map<String, dynamic>>>obtenerDependientes(String codUsuario) async {
    try {
      final url =
          Uri.http(_UrlBase, 'api/Dependiente/ObtenerDependientes/$codUsuario');
      final resp = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (resp.statusCode == 200) {
      final dynamic data = json.decode(resp.body);

      if (data is List<dynamic>) {
        // Si la respuesta es una lista de objetos, puedes devolverla directamente
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Error: La respuesta no es una lista de objetos');
        return []; // Devuelve una lista vacía en caso de un formato de respuesta incorrecto
      }
    } else {
      print('Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
      // En caso de error, puedes lanzar una excepción para manejarla más adelante
      throw Exception('Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
    }
  } catch (error) {
    print('Excepción al obtener datos del usuario: $error');
    // En caso de excepción, puedes lanzarla para manejarla más adelante
    throw Exception('Excepción al obtener datos del usuario: $error');
  }
}
}
