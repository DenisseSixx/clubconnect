import 'package:clubconnect/screens/claseseve.dart';
import 'package:clubconnect/screens/gastos.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClubConnect Demo',
      initialRoute: 'login',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
       // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //  useMaterial3: true, 
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
         primaryColor: Colors.cyan
      ),
      routes: {
      'login':(_)=> Login(),
      'home':(_)=> home(),
      'registro':(_)=> Registro(),
      'perfil':(_)=>Perfil(), 
      'ajustes': (_)=> settings(), 
      'notificaciones':(_)=> noti(),
      'claseve':(_)=> even(),
      'gastos':(_)=> gastos()
      }
    );
  }
}
