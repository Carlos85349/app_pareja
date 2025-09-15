import 'package:flutter/material.dart';
import 'menu_principal.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Para Mi Novia 💖",
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const MenuPrincipal(),
    );
  }
}