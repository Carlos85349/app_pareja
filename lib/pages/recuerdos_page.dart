import 'package:flutter/material.dart';
import 'detalle_recuerdo_page.dart';
import '../service/recuerdos_data.dart';
import '../widgets/fondo_dinamico.dart'; // <- ajusta la ruta si tu widget está en otra carpeta

class RecuerdosPage extends StatelessWidget {
  const RecuerdosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Fondo dinámico aplicado
      body: FondoDinamico(
        tipo: "recuerdos",
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          itemCount: recuerdosData.length,
          itemBuilder: (context, index) {
            final recuerdo = recuerdosData[index];
            return Card(
              margin: const EdgeInsets.all(8),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                title: Text(
                  recuerdo["nombre"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
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