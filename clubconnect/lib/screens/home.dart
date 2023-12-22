import 'package:clubconnect/widgets/drawer.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
       title: Text('ClubConnect', style: TextStyle(fontFamily:'Outfit', fontSize: 20, fontWeight: FontWeight.normal)
       ),
       actions: [IconButton(icon: Icon(Icons.notifications),
       onPressed: () {Navigator.pushNamed(context, 'notificaciones');}),],
       //backgroundColor: Colors.amber,

      ),
      drawer: MenuDrawer(),
    );
  }
}