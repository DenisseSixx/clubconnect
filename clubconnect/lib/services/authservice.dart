import 'dart:convert';
import 'package:clubconnect/models/autorizacion_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _UrlBase = '10.0.0.19:5272';

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
     try {
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
  } catch (e) {
    print('Usuario o contraseña incorrectos: $e');
    return 'Usuario o contraseña incorrectos';
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

  Future<List<Map<String, dynamic>>> ObtenerEstadoCuenta(
      String codUsuario) async {
    try {
      final url =
          Uri.http(_UrlBase, 'api/Cuentas/ObtenerEstadoCuenta/$codUsuario');
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
        print(
            'Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
        // En caso de error, puedes lanzar una excepción para manejarla más adelante
        throw Exception(
            'Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
      }
    } catch (error) {
      print('Excepción al obtener datos del usuario: $error');
      // En caso de excepción, puedes lanzarla para manejarla más adelante
      throw Exception('Excepción al obtener datos del usuario: $error');
    }
  }

  Future<List<Map<String, dynamic>>> obtenerDependientes(
      String codUsuario) async {
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
        print(
            'Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
        // En caso de error, puedes lanzar una excepción para manejarla más adelante
        throw Exception(
            'Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
      }
    } catch (error) {
      print('Excepción al obtener datos del usuario: $error');
      // En caso de excepción, puedes lanzarla para manejarla más adelante
      throw Exception('Excepción al obtener datos del usuario: $error');
    }
  }

  Future<void> updateAppautorizaciond(
      String codTercero, int codDependiente, bool codAutorizacion) async {
    final url = Uri.http(_UrlBase,
        'api/Appautorizacionds/EditarEstado/$codTercero/$codDependiente');

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(codAutorizacion),
      );

      if (response.statusCode == 204) {
        print('Estado de Appautorizaciond actualizado correctamente.');
      } else if (response.statusCode == 404) {
        print('La Appautorizaciond no existe, creando una nueva...');
        await CrearAutorizacion(codTercero, codDependiente, codAutorizacion);
      } else {
        print(
            'Error al actualizar el estado de Appautorizaciond. Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> CrearAutorizacion(
      String codTercero, int codDependiente, bool codAutorizacion) async {
    try {
      final Map<String, dynamic> data = {
        'codTercero': codTercero,
        'codDependiente': codDependiente,
        'codAutorizacion': codAutorizacion
      };

      final url = Uri.http(_UrlBase, 'api/Appautorizacionds/Crear');

      final resp = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      print('Código de estado de la respuesta: ${resp.statusCode}');
      print('Respuesta del servidor: ${resp.body}');

      if (resp.statusCode == 200) {
        print('Autorizacion agregada con éxito');
      } else {
        print('Error al agregar. Detalles: ${resp.body}');
      }
    } catch (error) {
      print('Excepción al agregar: $error');
    }
  }

  Future<List<Map<String, dynamic>>> ObtenerEstadoDependiente(
      String codTercero) async {
    try {
      final url = Uri.http(
          _UrlBase, 'api/Appautorizacionds/ObtenerDepenTer/$codTercero');
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
        print(
            'Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
        // En caso de error, puedes lanzar una excepción para manejarla más adelante
        throw Exception(
            'Error al obtener datos del usuario. Código de estado: ${resp.statusCode}');
      }
    } catch (error) {
      print('Excepción al obtener datos del usuario: $error');
      // En caso de excepción, puedes lanzarla para manejarla más adelante
      throw Exception('Excepción al obtener datos del usuario: $error');
    }
  }

  Future<String?> getCodTercero(String codUsuario) async {
    try {
      final url = Uri.http(
          _UrlBase, 'api/Appusuarios/ObtenerPorIDCodTercero/$codUsuario');
      final resp = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (resp.statusCode == 200) {
        final dynamic data = json.decode(resp.body);

        // Convertir el valor entero a cadena
        final codTercero = data.toString();

        return codTercero;
      } else {
        print('Error al obtener el codTercero: ${resp.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error al realizar la solicitud HTTP: $error');
      return null;
    }
  }

  Future<List<Appautorizaciond>> obtenerAutorizaciones(
      String codTercero) async {
    final url = Uri.http(
        _UrlBase, 'api/Appautorizacionds/ObtenerPorCodTercero/$codTercero');

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Appautorizaciond> autorizaciones =
            jsonData.map((item) => Appautorizaciond.fromJson(item)).toList();
        return autorizaciones;
      } else {
        print('Error al obtener las autorizaciones: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error al realizar la solicitud HTTP: $error');
      return [];
    }
  }
   Future<bool> verificarAutorizacion(String codUsuario) async {
    
       final url = Uri.http(
        _UrlBase,'api/Appautorizacionds/VerificarAutorizacion/$codUsuario');

      try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );


      if (response.statusCode == 200) {
        // Si el estado de la respuesta es OK (200), decodifica el cuerpo de la respuesta JSON
        // y devuelve el valor booleano recibido del servidor
        return jsonDecode(response.body);
      } else {
        // Si hay un error en la respuesta, lanza una excepción
        throw Exception('Error al verificar autorización: ${response.statusCode}');
      }
    } catch (e) {
      // Captura cualquier excepción que ocurra durante la solicitud HTTP
      throw Exception('Error al conectarse al servidor: $e');
    }
  }
   Future<int?> getCodDependiente(String codUsuario) async {
     final url = Uri.http(
        _UrlBase,'api/Appautorizacionds/ObtenerCodDependiente/$codUsuario');
         try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // Si el estado de la respuesta es OK (200), decodifica el cuerpo de la respuesta JSON
        // y devuelve el CodDependiente recibido del servidor
        return jsonDecode(response.body);
      } else {
        // Si hay un error en la respuesta, lanza una excepción
        throw Exception('Error al obtener el CodDependiente: ${response.statusCode}');
      }
    } catch (e) {
      // Captura cualquier excepción que ocurra durante la solicitud HTTP
      throw Exception('Error al conectarse al servidor: $e');
    }
  }
  Future<void> CambiarContrasena(
  String codUsuario, String claUsuario) async {
  final url = Uri.http(_UrlBase,
      '/api/Appusuarios/EditarContrasena/$codUsuario');

  try {
    print('Contraseña que se enviará: $claUsuario'); // Imprime la contraseña que se enviará
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(claUsuario),
    );

    if (response.statusCode == 201) {
      print('Contraseña actualizada correctamente.');
    } else if (response.statusCode == 204) {
      print('Contraseña actualizada correctamente.');
    } else {
      print('Error al actualizar la contraseña. Código de estado: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

      
}



