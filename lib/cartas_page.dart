import 'package:flutter/material.dart';

class CartasPage extends StatelessWidget {
  final List<String> cartas = [
    "Carta 1: Eres la persona más especial 💖",
    "Carta 2: Gracias por estar conmigo 🌹",
    "Carta 3: Te amo infinito 💕"
  ];

  CartasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Cartas 💌")),
      body: ListView.builder(
        itemCount: cartas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                cartas[index],
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
            ),
          );
        },
      ),
    );
  }
}
