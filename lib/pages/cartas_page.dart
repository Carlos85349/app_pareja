import 'package:flutter/material.dart';
import '../service/cartas_service.dart';
import 'detalle_carta_page.dart';
import '../widgets/fondo_dinamico.dart'; // <- ajusta la ruta si tu widget está en otra carpeta

class CartasPage extends StatefulWidget {
  const CartasPage({super.key});

  @override
  State<CartasPage> createState() => _CartasPageState();
}

class _CartasPageState extends State<CartasPage> {
  final CartasService cartasService = CartasService();
  late Future<List<Map<String, dynamic>>> _cartasFuture;

  @override
  void initState() {
    super.initState();
    _cartasFuture = cartasService.fetchCartas(); // leer JSON local
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo gestionado por FondoDinamico
      body: FondoDinamico(
        tipo: "cartas",
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _cartasFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error cargando cartas: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No hay cartas disponibles"));
            }

            final cartas = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: cartas.length,
              itemBuilder: (context, index) {
                final carta = cartas[index];
                final fecha = carta['fecha'] ?? 'Sin fecha';
                final contenido = carta['contenido'] ?? '';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    title: Text(
                      fecha,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      contenido,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetalleCartaPage(
                            cartas: cartas,   // 🔹 lista completa
                            indice: index,    // 🔹 índice de la carta seleccionada
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}