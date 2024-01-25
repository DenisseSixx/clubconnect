import 'package:clubconnect/interfaces/idatos';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Servicios implements IDatos{
  static final Servicios inst = Servicios._internal();
  Servicios._internal() { }
  factory Servicios(){
    return inst;
  }
  @override
  Future<List<dynamic>> Buscar(String http_s, String urlBase, String ruta, String metodo, Map<String, dynamic>? parametros) async {
    final response = await Peticion.HacerPeticion(http_s,urlBase,ruta,metodo,parametros);
    if (response.statusCode == 200) {
      // Si la llamada al servidor fue exitosa, analiza el JSON
      return json.decode(response.body);
    } else {
      // Si la llamada no fue exitosa, lanza un error.
      throw Exception('Error al buscar');
    }
  }
  @override
  Future<bool> Agregar(String http_s, String urlBase, String ruta, String metodo, Map<String, dynamic>? parametros) async {
    final response = await Peticion.HacerPeticion(http_s,urlBase,ruta,metodo,parametros);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  @override
  Future<bool> Guardar(String http_s, String urlBase, String ruta, String metodo, Map<String, dynamic> parametros) async {
    final response = await Peticion.HacerPeticion(http_s,urlBase,ruta,metodo,parametros);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class Peticion{
  static final Peticion inst = Peticion._internal();
  Peticion._internal() { }
  factory Peticion(){
    return inst;
  }
  static Future<http.Response> HacerPeticion(String http_s, String urlBase, String ruta, String metodo, Map<String, dynamic>? parametros) async {
    if(http_s == 'http'){
      switch (metodo.toLowerCase()) {
        case 'get':
          if(parametros != null){
            return await http.get(Uri.http(urlBase, ruta, parametros), headers: {"Content-Type": "application/json"});
          }else{
            return await http.get(Uri.http(urlBase, ruta), headers: {"Content-Type": "application/json"});
          }
        case 'post':
          if(parametros != null){
            return await http.post(Uri.http(urlBase, ruta), body: json.encode(parametros), headers: {"Content-Type": "application/json"});
          }else{
            return await http.post(Uri.http(urlBase, ruta), headers: {"Content-Type": "application/json"});
          }
        default:
          return http.Response('Error en la peticion', 400);
      }
    }else{
      switch (metodo.toLowerCase()) {
        case 'get':
          if(parametros != null){
            return await http.get(Uri.https(urlBase, ruta, parametros), headers: {"Content-Type": "application/json"});
          }else{
            return await http.get(Uri.https(urlBase, ruta), headers: {"Content-Type": "application/json"});
          }
        case 'post':
          if(parametros != null){
            return await http.post(Uri.https(urlBase, ruta), body: json.encode(parametros), headers: {"Content-Type": "application/json"});
          }else{
            return await http.post(Uri.https(urlBase, ruta), headers: {"Content-Type": "application/json"});
          }
        default:
          return http.Response('Error en la peticion', 400);
      }
    }
  }
}