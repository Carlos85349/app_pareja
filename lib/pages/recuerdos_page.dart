import 'package:flutter/material.dart';

class RecuerdosPage extends StatelessWidget {
  const RecuerdosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Recuerdos 🌸")),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aquí irían mis recuerdos contigo.",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Icon(Icons.photo, size: 100, color: Colors.pink),
          ],
        ),
      ),
    );
  }
}