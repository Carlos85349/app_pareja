import 'package:flutter/material.dart';
import 'detalle_carta_page.dart';

class CartasPage extends StatelessWidget {
  CartasPage({super.key});

  final List<String> cartas = [
    "Eres la persona más especial 💖",
    "Gracias por estar conmigo 🌹",
    "Te amo infinito 💕"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Cartas 💌"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalleCartaPage(
                      titulo: "Carta ${index + 1}",
                      contenido: cartas[index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Carta ${index + 1}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}