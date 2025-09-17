import 'package:flutter/material.dart';
import '../service/cartas_service.dart';

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
      appBar: AppBar(title: const Text("Mis Cartas 💌")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
            itemCount: cartas.length,
            itemBuilder: (context, index) {
              final carta = cartas[index]; // cada carta es un Map<String, dynamic>

              // Puedes acceder a los campos según tu JSON
              final fecha = carta['fecha'] ?? 'Sin fecha';
              final contenido = carta['contenido'] ?? '';

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(fecha, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(contenido),
                  onTap: () {
                    // Si quieres, aquí puedes navegar a una página detalle
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartaDetallePage(carta: carta),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CartaDetallePage extends StatelessWidget {
  final Map<String, dynamic> carta;
  const CartaDetallePage({super.key, required this.carta});

  @override
  Widget build(BuildContext context) {
    final fecha = carta['fecha'] ?? '';
    final contenido = carta['contenido'] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(fecha)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity, // fuerza ancho de pantalla
          child: Text(
            contenido,
            style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              height: 1.5, // más legible
            ),
            textAlign: TextAlign.justify,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}