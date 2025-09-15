import 'package:flutter/material.dart';
import 'recuerdos_page.dart';
import 'cartas_page.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(backgroundColor: Colors.pink[100],
        title: const Text("Carlos y Berenice ❤️"),
        centerTitle: true,
        elevation: 0, // quita sombra para que solo se vea la línea
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1), // altura de la línea
          child: Container(
            color: Colors.black, // línea negra
            height: 1,
          ),
        ), 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("📸 Ver mis Recuerdos"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecuerdosPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("💌 Ver mis cartas"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartasPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}