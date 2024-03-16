import 'package:flutter/material.dart';

class SaDependiente {
  late String codEmpresa;
  late String codCliente;
  late String codTercero;
  late int codDependiente;
  late String nombre;
  late DateTime fecNacimiento;
  late String codCredencial;
  double? limiteCredito;
  double? saldoCredito;
  late String codEstado;
  late List<Expediente> expedientes;
  //late SaTercero saTercero;

  SaDependiente({
    required this.codEmpresa,
    required this.codCliente,
    required this.codTercero,
    required this.codDependiente,
    required this.nombre,
    required this.fecNacimiento,
    required this.codCredencial,
    this.limiteCredito,
    this.saldoCredito,
    required this.codEstado,
    required this.expedientes,
    //required this.saTercero,
  });

  SaDependiente.fromJson(Map<String, dynamic> json) {
    codEmpresa = json['codEmpresa'];
    codCliente = json['codCliente'];
    codTercero = json['codTercero'];
    codDependiente = json['codDependiente'];
    nombre = json['nombre'];
    fecNacimiento = DateTime.parse(json['fecNacimiento']);
    codCredencial = json['codCredencial'];
    limiteCredito = json['limiteCredito'];
    saldoCredito = json['saldoCredito'];
    codEstado = json['codEstado'];
    if (json['expedientes'] != null) {
      expedientes = <Expediente>[];
      json['expedientes'].forEach((v) {
        expedientes.add(Expediente.fromJson(v));
      });
    }
    //saTercero = SaTercero.fromJson(json['saTercero']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codEmpresa'] = codEmpresa;
    data['codCliente'] = codCliente;
    data['codTercero'] = codTercero;
    data['codDependiente'] = codDependiente;
    data['nombre'] = nombre;
    data['fecNacimiento'] = fecNacimiento.toIso8601String();
    data['codCredencial'] = codCredencial;
    data['limiteCredito'] = limiteCredito;
    data['saldoCredito'] = saldoCredito;
    data['codEstado'] = codEstado;
    data['expedientes'] = expedientes.map((v) => v.toJson()).toList();
   // data['saTercero'] = saTercero.toJson();
    return data;
  }
}

class Expediente {
  late int id;
  late String nombre;

  Expediente({
    required this.id,
    required this.nombre,
  });

  Expediente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    return data;
  }
}

class SaTercero {
  late String property1;
  late String property2;

  SaTercero({
    required this.property1,
    required this.property2,
  });

  SaTercero.fromJson(Map<String, dynamic> json) {
    property1 = json['property1'];
    property2 = json['property2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['property1'] = property1;
    data['property2'] = property2;
    return data;
  }
}
