import 'package:flutter/material.dart';
import 'recuerdos_page.dart';
import 'cartas_page.dart';
import 'inicio_page.dart';
import '../widgets/fondo_dinamico.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int _selectedIndex = 0;
  DateTime? _lastPressed;

  final List<Widget> _pages = const [
    InicioPage(),
    RecuerdosPage(),
    CartasPage(),
  ];

  final List<String> _fondos = [
    "inicio",
    "recuerdos",
    "cartas",
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _onBackPressed(bool canPop, dynamic result) {
    if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
    } else {
      final now = DateTime.now();
      if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
        _lastPressed = now;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Presione otra vez para salir"),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        Navigator.of(context).maybePop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: _onBackPressed,
      child: Scaffold(
        body: FondoDinamico(
          tipo: _fondos[_selectedIndex],
          child: Column(
            children: [
              // AppBar simulado dentro de SafeArea con línea divisoria
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      child: const Text(
                        "Carlos y Berenice ❤️",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          shadows: [
                            Shadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Línea divisoria
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color.fromARGB(255, 238, 209, 209),
                    ),
                  ],
                ),
              ),

              // Contenido de la página
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: _pages[_selectedIndex],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.pinkAccent.shade200,
            unselectedItemColor: Colors.grey.shade600,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Inicio",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.photo_album_outlined),
                activeIcon: Icon(Icons.photo_album),
                label: "Recuerdos",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline),
                activeIcon: Icon(Icons.mail),
                label: "Cartas",
              ),
            ],
          ),
        ),
      ),
    );
  }
}