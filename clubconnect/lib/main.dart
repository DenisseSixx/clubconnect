import 'package:clubconnect/models/usuarios_response.dart';
import 'package:clubconnect/providers/login_form_provider.dart';
import 'package:clubconnect/screens/asistencias.dart';
import 'package:clubconnect/screens/cambiocontrasena.dart';
import 'package:clubconnect/screens/claseseve.dart';
import 'package:clubconnect/screens/documentos.dart';
import 'package:clubconnect/screens/gastos.dart';
import 'package:clubconnect/screens/registrodep.dart';
import 'package:clubconnect/services/authservice.dart';
import 'package:clubconnect/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main()=>
    //HttpOverrides.global = new MyHttpOverrides();
   runApp(const AppState());


  class AppState extends StatelessWidget {
  const AppState({super.key});

  @override //ANTES S ECORRIA MYAPP PRIMERO, AHORA ES EL APPSTATE QUE TIENE L PROVIDER, MANEJADOR DE ESTADO.
  Widget build(BuildContext context) {
   
        
      
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(  create: (_) => AuthService(), 
        lazy:   false, //normalmetne es perezoso pero aqui hacemos que no sea asi e inicie al inicar la aplicacion
        ), 
      ],
      child: MyApp(),
    );//pide varios providers, depende si son varias peticiones http
  }
  }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      scaffoldMessengerKey: NotificationsService.messengerKey,
        debugShowCheckedModeBanner: false,
        title: 'ClubConnect Demo',
        initialRoute: 'login',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.cyan,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //  useMaterial3: true,
        ),
        darkTheme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.cyan),
        routes: {
          'login': (_) => const Login(),
          'home': (_) => const home(),
          'registro': (_) => const Registro(),
          'perfil': (_) => const Perfil(),
          'ajustes': (_) => const Settings(),
          'notificaciones': (_) => const noti(),
          'claseve': (_) => const even(),
          'gastos': (_) => const Gastos(),
          'asistencias': (_) => const RegistroH(),
          'dependientes': (_) => const RegistroDep(),
          'documentos': (_) => const Documentos(),
          'cambiocontra':(_) => const CambioContra()
        });
        
  }
  
// class MyHttpOverrides extends HttpOverrides{
//   @override
//  HttpClient createHttpClient(SecurityContext? context) 
//  { return super.createHttpClient(context) ..badCertificateCallback =
//   (X509Certificate cert, String host, int port) = true; }
}


