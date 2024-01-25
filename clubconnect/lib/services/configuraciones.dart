class Configuraciones{
  static String UrlBase = "";
  static String aliasUrl = "";
  static double ResolucionImagenesAncho = 0;
  static double ResolucionImagenesAlto = 0;
  static final Configuraciones inst = Configuraciones._internal();
  Configuraciones._internal() {  }
  factory Configuraciones(){
    return inst;
  }
  Configuraciones.fromJson(Map<String, dynamic> json){
    UrlBase = json['UrlBase'] as String;
    aliasUrl = json['aliasUrl'] as String;
    ResolucionImagenesAncho = json['ResolucionImagenesAncho'] as double;
    ResolucionImagenesAlto = json['ResolucionImagenesAlto'] as double;
  }
}