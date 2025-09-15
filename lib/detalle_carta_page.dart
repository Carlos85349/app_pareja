import 'package:flutter/material.dart';

class DetalleCartaPage extends StatelessWidget {
  final String titulo;
  final String contenido;

  const DetalleCartaPage({super.key, required this.titulo, required this.contenido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            contenido,
            style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}