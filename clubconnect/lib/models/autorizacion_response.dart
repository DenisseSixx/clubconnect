class Appautorizaciond {
  String codTercero;
  double codDependiente;
  bool? codAutorizacion;

  Appautorizaciond({
    required this.codTercero,
    required this.codDependiente,
    this.codAutorizacion,
  });

  factory Appautorizaciond.fromJson(Map<String, dynamic> json) {
    return Appautorizaciond(
      codTercero: json['codTercero'],
      codDependiente: json['codDependiente'].toDouble(),
      codAutorizacion: json['codAutorizacion'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codTercero'] = this.codTercero;
    data['codDependiente'] = this.codDependiente;
    data['codAutorizacion'] = this.codAutorizacion;
    return data;
  }
   Appautorizaciond.withCodTercero(String codTercero)
      : codTercero = codTercero,
        codDependiente = 0, // Valores predeterminados para otros campos
        codAutorizacion = false;
}
