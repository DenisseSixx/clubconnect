import 'package:clubconnect/models/usuarios_response.dart';
import 'package:clubconnect/services/authservice.dart';
import 'package:clubconnect/widgets/CoverImage_widget.dart';
import 'package:clubconnect/widgets/DecoratedListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatefulWidget {
  final List<Usuario> usuario;
  const MenuDrawer({Key? key, required this.usuario}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  bool? rol;

  @override
  void initState() {
    super.initState();
    // Obtén el rol del usuario antes de construir el Drawer de navegación
    // getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 7, 94, 84),
                  Color.fromARGB(255, 18, 140, 126),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: CoverImage(), // Suponiendo que CoverImage es tu widget
            ),
          ),
          SizedBox(height: 20),
          DecoratedListTile(
            leadingIcon: Icons.account_circle,
            title: 'Perfil',
            onTap: () => Navigator.pushNamed(context, 'perfil'),
          ),
          DecoratedListTile(
            leadingIcon: Icons.tv,
            title: 'Clases y eventos',
            onTap: () => Navigator.pushNamed(context, 'claseve'),
          ),
          DecoratedListTile(
            leadingIcon: Icons.shopping_bag,
            title: 'Consumos y gastos',
            onTap: () => Navigator.pushNamed(context, 'gastos'),
          ),
          DecoratedListTile(
            leadingIcon: Icons.settings,
            title: 'Ajustes',
            onTap: () => Navigator.pushNamed(context, 'ajustes'),
          ),
          DecoratedListTile(
            leadingIcon: Icons.exit_to_app,
            title: 'Salir',
            onTap: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      ),
    );
  }
}
