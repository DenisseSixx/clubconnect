import 'package:flutter/material.dart';

import 'widgets.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
    bool? rol;

   @override
  void initState() {
    super.initState();
    // Obtén el nombre del usuario antes de construir el cajón de navegación
  //  getUserRole();
  }
  /*Future<void> getUserRole() async {
    final userData = await readCompleteUser();
    if (userData != null && userData.isNotEmpty) {
      final user = userData[0]; // Suponemos que solo hay un usuario
      setState(() => rol = user.isAdm!);
    }
  }*/
  Widget build(BuildContext context) {
  List<Widget> drawerItems = [
    const DrawerHeader(
      child: CoverImage(),
    ),
    ListTile(
      leading: const Icon(Icons.account_circle),
      title: const Text('Perfil'),
      onTap: () {
        Navigator.pushNamed(context, 'perfil');
      },
    ),
    ListTile(
      leading: const Icon(Icons.tv),
      title: const Text('Clases y eventos'),
      onTap: () {
        Navigator.pushNamed(context, 'claseve');
      },
    ),
    ListTile(
      leading: const Icon(Icons.shopping_bag),
      title: const Text('Consumos y gastos'),
      onTap: () {
        Navigator.pushNamed(context, 'gastos');
      },
    ),
    ListTile(
      leading: const Icon(Icons.settings),
      title: const Text('Ajustes'),
      onTap: () {
        Navigator.pushNamed(context, 'ajustes');
      },
    ),
    ListTile(
      leading: const Icon(Icons.exit_to_app),
      title: const Text('Salir'),
      onTap: () {
        Navigator.pushReplacementNamed(context, 'login');
      },
    ),
    ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text('Registro de asistencias'),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'asistencias');
        },
      ),
  ];

  if (rol == true) {
    drawerItems.add(
      ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text('Registro de asistencias'),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'asistencias');
        },
      ),
    );
  }

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: drawerItems,
    ),
  );
}
}