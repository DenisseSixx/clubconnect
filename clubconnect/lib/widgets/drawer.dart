import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Text(
              'CountryClub',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              onTap: () {
                Navigator.pushNamed(context, 'perfil');
              }),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Clases y eventos'),
            onTap: () {
              Navigator.pushNamed(context, 'claseve');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Consumos y gastos'),
            onTap: () {
              Navigator.pushNamed(context, 'gastos');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
            onTap: () {
              Navigator.pushNamed(context, 'ajustes');
            },
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Salir'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'login');
              }),
        ],
      ),
    );
  }
}
