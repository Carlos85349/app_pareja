import 'package:flutter/material.dart';
import 'recuerdos_page.dart';
import 'cartas_page.dart';
import 'inicio_page.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  DateTime? _lastPressed; // para controlar el doble back

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
    setState(() => _selectedIndex = index);
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      // Si no está en Inicio → regresar a Inicio
      _onItemTapped(0);
      return false;
    }

    // Si está en Inicio → verificar doble back
    final now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Presione otra vez para salir de la aplicación"),
          duration: Duration(seconds: 1),
        ),
      );
      return false;
    }
    return true; // cierra la app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[100],
          title: const Text("Carlos y Berenice ❤️", style: TextStyle(color: Colors.black87)),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: const [
            InicioPage(),
            RecuerdosPage(),
            CartasPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.pink[100],
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.pink[900],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              label: "Recuerdos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: "Cartas",
            ),
          ],
        ),
      ),
    );
  }
}