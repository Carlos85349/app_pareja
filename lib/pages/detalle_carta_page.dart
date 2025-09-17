import 'package:flutter/material.dart';

class DetalleCartaPage extends StatelessWidget {
  final String fecha;
  final String contenido;

  const DetalleCartaPage({
    super.key,
    required this.fecha,
    required this.contenido,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fecha),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          contenido,
          style: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            height: 1.5, // separación entre líneas
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}