import 'package:flutter/material.dart';

class DetalleRecuerdoPage extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final List<String> imagenes;

  const DetalleRecuerdoPage({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.imagenes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(nombre)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var img in imagenes)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  img,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 350,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                descripcion,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
