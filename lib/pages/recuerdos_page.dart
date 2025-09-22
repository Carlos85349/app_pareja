import 'package:flutter/material.dart';
import 'detalle_recuerdo_page.dart';
import 'recuerdos_data.dart';

class RecuerdosPage extends StatelessWidget {
  const RecuerdosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8F0), Color(0xFFF4A7B9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: recuerdosData.length,
          itemBuilder: (context, index) {
            final recuerdo = recuerdosData[index];
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              child: ListTile(
                title: Text(
                  recuerdo["nombre"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalleRecuerdoPage(
                        listaRecuerdos: recuerdosData,
                        indice: index,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}