class Configuraciones{
  static String urlBase = '10.0.0.31:5272';
  static String aliasUrl = "";
  static double ResolucionImagenesAncho = 0;
  static double ResolucionImagenesAlto = 0;
  static final Configuraciones inst = Configuraciones._internal();
  Configuraciones._internal() {  }
  factory Configuraciones(){
    return inst;
  }
  Configuraciones.fromJson(Map<String, dynamic> json){
    urlBase = json['UrlBase'] as String;
    aliasUrl = json['aliasUrl'] as String;
    ResolucionImagenesAncho = json['ResolucionImagenesAncho'] as double;
    ResolucionImagenesAlto = json['ResolucionImagenesAlto'] as double;
  }
}