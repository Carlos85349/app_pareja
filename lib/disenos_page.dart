import 'package:flutter/material.dart';

class DisenosPage extends StatelessWidget {
  const DisenosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Recuerdos 🌸")),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/flor1.png"),
            Image.asset("assets/flor2.png"),
          ],
        ),
      ),
    );
  }
}