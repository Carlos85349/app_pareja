import 'package:flutter/material.dart';
import '../widgets/fondo_dinamico.dart'; // 👈 ajusta la ruta

class DetalleRecuerdoPage extends StatelessWidget {
  final List<Map<String, dynamic>> listaRecuerdos;
  final int indice;

  const DetalleRecuerdoPage({
    super.key,
    required this.listaRecuerdos,
    required this.indice,
  });

  @override
  Widget build(BuildContext context) {
    final recuerdo = listaRecuerdos[indice];
    final String nombre = recuerdo["nombre"];
    final String descripcion = recuerdo["descripcion"];
    final List<String> imagenes = List<String>.from(recuerdo["archivos"]);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FondoDinamico(
        tipo: "recuerdos", // 👈 mismo fondo que en RecuerdosPage
        child: SafeArea(
          child: Column(
            children: [
              // Botón regresar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),

              // Contenido scrollable centrado
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: size.height - 160),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Título
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Text(
                              nombre,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          // Imágenes
                          for (var img in imagenes)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  img,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 400,
                                ),
                              ),
                            ),

                          // Descripción
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Text(
                              descripcion,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Botones siguiente/anterior fijos abajo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (indice > 0)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalleRecuerdoPage(
                                    listaRecuerdos: listaRecuerdos,
                                    indice: indice - 1,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.pinkAccent.shade200,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.pinkAccent.shade200),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              "Recuerdo Anterior",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    if (indice < listaRecuerdos.length - 1)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalleRecuerdoPage(
                                    listaRecuerdos: listaRecuerdos,
                                    indice: indice + 1,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.pinkAccent.shade200,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.pinkAccent.shade200),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              "Siguiente Recuerdo",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}