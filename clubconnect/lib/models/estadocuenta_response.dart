import 'package:flutter/material.dart';

class EstadoCuenta1 {
  late DateTime codPeriodo;
  late int codImporte;
  late String codTipo;
  late String codSubtipo;
  late String titulo;
  late double desImporte;
  late double montoOriginal;
  late double monAdeudoAnterior;
  late double monAdeudoAnteriorSinRecargo;
  late double recargo;
  late double monAbono;
  late double bonificacion;
  late double montoDescuento;
  late double monSubtotalAdeudo;
  late double porIva;
  late double monIvaAdeudo;
  late double monTotalAdeudo;
  late double aFavorAplicado;
  late double cobradoAplicado;

  EstadoCuenta1({
    required this.codPeriodo,
    required this.codImporte,
    required this.codTipo,
    required this.codSubtipo,
    required this.titulo,
    required this.desImporte,
    required this.montoOriginal,
    required this.monAdeudoAnterior,
    required this.monAdeudoAnteriorSinRecargo,
    required this.recargo,
    required this.monAbono,
    required this.bonificacion,
    required this.montoDescuento,
    required this.monSubtotalAdeudo,
    required this.porIva,
    required this.monIvaAdeudo,
    required this.monTotalAdeudo,
    required this.aFavorAplicado,
    required this.cobradoAplicado,
  });

  EstadoCuenta1.fromJson(Map<String, dynamic> json) {
    codPeriodo = DateTime.parse(json['codPeriodo']);
    codImporte = json['codImporte'];
    codTipo = json['codTipo'];
    codSubtipo = json['codSubtipo'];
    titulo = json['titulo'];
    desImporte = json['desImporte'];
    montoOriginal = json['montoOriginal'];
    monAdeudoAnterior = json['monAdeudoAnterior'];
    monAdeudoAnteriorSinRecargo = json['monAdeudoAnteriorSinRecargo'];
    recargo = json['recargo'];
    monAbono = json['monAbono'];
    bonificacion = json['bonificacion'];
    montoDescuento = json['montoDescuento'];
    monSubtotalAdeudo = json['monSubtotalAdeudo'];
    porIva = json['porIva'];
    monIvaAdeudo = json['monIvaAdeudo'];
    monTotalAdeudo = json['monTotalAdeudo'];
    aFavorAplicado = json['aFavorAplicado'];
    cobradoAplicado = json['cobradoAplicado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codPeriodo'] = codPeriodo.toIso8601String();
    data['codImporte'] = codImporte;
    data['codTipo'] = codTipo;
    data['codSubtipo'] = codSubtipo;
    data['titulo'] = titulo;
    data['desImporte'] = desImporte;
    data['montoOriginal'] = montoOriginal;
    data['monAdeudoAnterior'] = monAdeudoAnterior;
    data['monAdeudoAnteriorSinRecargo'] = monAdeudoAnteriorSinRecargo;
    data['recargo'] = recargo;
    data['monAbono'] = monAbono;
    data['bonificacion'] = bonificacion;
    data['montoDescuento'] = montoDescuento;
    data['monSubtotalAdeudo'] = monSubtotalAdeudo;
    data['porIva'] = porIva;
    data['monIvaAdeudo'] = monIvaAdeudo;
    data['monTotalAdeudo'] = monTotalAdeudo;
    data['aFavorAplicado'] = aFavorAplicado;
    data['cobradoAplicado'] = cobradoAplicado;
    return data;
  }
}
