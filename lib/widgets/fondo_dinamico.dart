import 'package:flutter/material.dart';

class FondoDinamico extends StatelessWidget {
  final Widget child; // contenido encima del fondo
  final String tipo;  // nombre de la pantalla para variar fondos

  const FondoDinamico({
    super.key,
    required this.child,
    required this.tipo,
  });

  // 🔹 método que devuelve un fondo según el tipo
  BoxDecoration _buildBackground(String tipo) {
    switch (tipo) {
      case "inicio":
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8F0), Color(0xFFF4A7B9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        );
      case "recuerdos":
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8F0), Color.fromARGB(255, 255, 75, 75)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        );
      case "cartas":
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8F0), Color.fromARGB(255, 216, 164, 97)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        );
      default:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8F0), Color(0xFFF4A7B9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBackground(tipo), // aplica fondo dinámico
      child: child, // muestra el contenido encima del fondo
    );
  }
}