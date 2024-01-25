
import 'package:intl/intl.dart';

class AsistenciaService {
  final String? objectId;
  final String? fecha;
  final String? fullname;

  AsistenciaService({
    this.objectId,
    this.fecha,
    this.fullname,
  });

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "fecha": fecha,
        "fullname": fullname,
      };
}

Future<void> addAsistencia() async {
  
}

Future<List<AsistenciaService>> readAsistencias() async {
 
 
}

Future<List<AsistenciaService>> readAsistenciasUsuario(String objectId) async {
 
}


Future<void> updateAsistencia(String originalFecha, AsistenciaService asistenciaService,String fullname) async {

}


Future<void> deleteAsistencia(String fecha, String fullname) async {
 
}

Future<void> addAsistenciaUsuario(String fullname) async {
 
}
Future<void> addAsistenciaUsuarioFecha(String fullname, String fecha) async {
  
}

Future<List<AsistenciaService>> readAsistenciasGeneral() async {
  
}
