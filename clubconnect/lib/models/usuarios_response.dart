class Usuario {
  final String codTercero;
  final int codDependiente;
  final String codUsuario;
  final String nomUsuario;
  final String claUsuario;
  final String nombre;
  final String correo;
  final String codEstusu;

  Usuario({
    required this.codTercero,
    required this.codDependiente,
    required this.codUsuario,
    required this.nomUsuario,
    required this.claUsuario,
    required this.nombre,
    required this.correo,
    required this.codEstusu,
  });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    
      codTercero: json['codTercero'] ?? '',
      codDependiente: json['codDependiente'] ?? 0,
      codUsuario: json['codUsuario'] ?? '',
      nomUsuario: json['nomUsuario'] ?? '',
      claUsuario: json['claUsuario'] ?? '',
      nombre: json['nombre'], // Puede ser nulo
      correo: json['correo'] ?? '',
      codEstusu: json['codEstusu'] ?? '',
    );
    Map<String, dynamic> toJson()=>{
      
      "codTercero":codTercero,
      "codDependiente": codDependiente,
      "codUsuario": codUsuario,
      "nomUsuario": nomUsuario,
      "claUsuario": claUsuario,
      "nombre": nombre, // Puede ser nulo
      "correo": correo,
      "codEstusu": codEstusu,
    };
  }

