import 'package:flutter/material.dart';
import '../widgets/fondo_dinamico.dart';

class DetalleCartaPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartas;
  final int indice;

  const DetalleCartaPage({
    super.key,
    required this.cartas,
    required this.indice,
  });

  @override
  State<DetalleCartaPage> createState() => _DetalleCartaPageState();
}

class _DetalleCartaPageState extends State<DetalleCartaPage> {
  late PageController _pageController;
  late int _currentIndice;

  @override
  void initState() {
    super.initState();
    _currentIndice = widget.indice;
    _pageController = PageController(initialPage: _currentIndice);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _irACarta(int nuevoIndice) {
    if (nuevoIndice >= 0 && nuevoIndice < widget.cartas.length) {
      _pageController.animateToPage(
        nuevoIndice,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndice = nuevoIndice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FondoDinamico(
        tipo: "cartas",
        child: SafeArea(
          child: Column(
            children: [
              // Botón de regresar
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

              // PageView con swipe horizontal entre cartas
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.cartas.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndice = index);
                  },
                  itemBuilder: (context, index) {
                    final carta = widget.cartas[index];
                    final fecha = carta['fecha'] ?? '';
                    final contenido = carta['contenido'] ?? '';

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: size.height - 160),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Fecha
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Text(
                                  fecha,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              // Contenido
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Text(
                                  contenido,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Botones siguiente/anterior
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentIndice > 0)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                            onPressed: () => _irACarta(_currentIndice - 1),
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
                              "Carta Anterior",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    if (_currentIndice < widget.cartas.length - 1)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ElevatedButton(
                            onPressed: () => _irACarta(_currentIndice + 1),
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
                              "Siguiente Carta",
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