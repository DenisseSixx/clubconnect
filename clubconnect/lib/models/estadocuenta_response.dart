class EstadoCuenta1{
  DateTime codPeriodo;
  double codImporte;
  String codTipo;
  String codSubtipo;
  String titulo;
  String desImporte;
  double montoOriginal;
  double monAdeudoAnterior;
  double monAdeudoAnteriorSinRecargo;
  double recargo;
  double monAbono;
  double bonificacion;
  double montoDescuento;
  double monSubtotalAdeudo;
  double porIva;
  double monIvaAdeudo;
  double monTotalAdeudo;
  double aFavorAplicado;
  double cobradoAplicado;

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

  factory EstadoCuenta1.fromJson(Map<String, dynamic> json) {
    return EstadoCuenta1(
      codPeriodo: DateTime.parse(json['codPeriodo']),
      codImporte: json['codImporte'].toDouble(),
      codTipo: json['codTipo'],
      codSubtipo: json['codSubtipo'],
      titulo: json['titulo'],
      desImporte: json['desImporte'],
      montoOriginal: json['montoOriginal'].toDouble(),
      monAdeudoAnterior: json['monAdeudoAnterior'].toDouble(),
      monAdeudoAnteriorSinRecargo: json['monAdeudoAnteriorSinRecargo'].toDouble(),
      recargo: json['recargo'].toDouble(),
      monAbono: json['monAbono'].toDouble(),
      bonificacion: json['bonificacion'].toDouble(),
      montoDescuento: json['montoDescuento'].toDouble(),
      monSubtotalAdeudo: json['monSubtotalAdeudo'].toDouble(),
      porIva: json['porIva'].toDouble(),
      monIvaAdeudo: json['monIvaAdeudo'].toDouble(),
      monTotalAdeudo: json['monTotalAdeudo'].toDouble(),
      aFavorAplicado: json['aFavorAplicado'].toDouble(),
      cobradoAplicado: json['cobradoAplicado'].toDouble(),
    );
  }
}
