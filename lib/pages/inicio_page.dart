import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/fondo_dinamico.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> with AutomaticKeepAliveClientMixin {
  final List<String> _imagenes = [
    "assets/images/foto1.jpg",
    "assets/images/foto2.jpg",
    "assets/images/foto3.jpg",
    "assets/images/foto4.jpg",
    "assets/images/foto5.jpg",
    "assets/images/foto6.jpg",
    "assets/images/foto7.jpg",
    "assets/images/foto8.jpg",
    "assets/images/foto9.jpg",
    "assets/images/foto10.jpg",
    "assets/images/foto11.jpg",
    "assets/images/foto12.jpg",
    "assets/images/foto13.jpg",
    "assets/images/foto14.jpg",
    "assets/images/foto15.jpg",
    "assets/images/foto16.jpg",
    "assets/images/foto17.jpg",
    "assets/images/foto18.jpg",
    "assets/images/foto19.jpg",
    "assets/images/foto20.jpg",
    "assets/images/foto21.jpg",
    "assets/images/foto22.jpg",
    "assets/images/foto23.jpg",
    "assets/images/foto24.jpg",
    "assets/images/foto25.jpg",
    "assets/images/foto26.jpg",
    "assets/images/foto27.jpg",
    "assets/images/foto28.jpg",
    "assets/images/foto29.jpg",
    "assets/images/foto30.jpg",
    "assets/images/foto31.jpg",
    "assets/images/foto32.jpg",
    "assets/images/foto33.jpg",
    "assets/images/foto34.jpg",
  ];

  final List<String> _frases = [
    "Sos lo más bonito que tengo 💕",
    "Con vos todo es mejor 🌹",
    "Mi felicidad sos vos ✨",
    "Amo tenerte en mi vida ❤️",
    "Sos mi lugar favorito en el mundo 🌎",
    "Cada día te amo más 😘",
    "Gracias por ser parte de mi vida 💖",
    "Sos mi sueño hecho realidad 🌟",
    "Con vos mi vida es mucho mejor 💫",
    "Sos mi todo, mi amor 💞",
  ];

  // Fechas para los contadores
  final DateTime inicioHablar = DateTime(2024, 8, 29);
  final DateTime inicioNovios = DateTime(2025, 3, 30);

  static int _lastPage = 0;
  late final PageController _pageController = PageController(initialPage: _lastPage);

  int _currentPage = _lastPage;
  String _fraseActual = "";
  late Timer _timerFrases;
  late Timer _timerImagenes;
  final Random _random = Random();

  int _diasHablar = 0;
  int _diasNovios = 0;

  @override
  void initState() {
    super.initState();
    _cambiarFrase();
    _calcularDias();

    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? _currentPage;
      if (_currentPage != newPage) {
        _currentPage = newPage;
        _lastPage = newPage;
      }
    });

    _timerFrases = Timer.periodic(const Duration(seconds: 5), (_) => _cambiarFrase());

    _timerImagenes = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_currentPage < _imagenes.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _lastPage = _currentPage;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _cambiarFrase() {
    setState(() {
      _fraseActual = _frases[_random.nextInt(_frases.length)];
    });
  }

  void _calcularDias() {
    final hoy = DateTime.now();
    _diasHablar = hoy.difference(inicioHablar).inDays;
    _diasNovios = hoy.difference(inicioNovios).inDays;
  }

  @override
  void dispose() {
    _timerFrases.cancel();
    _timerImagenes.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FondoDinamico(
      tipo: "inicio",
      child: Stack(
        children: [
          // Fotos
          PageView.builder(
            key: const PageStorageKey('inicioPageView'),
            controller: _pageController,
            itemCount: _imagenes.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      _imagenes[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),

          // Contadores de días en esquinas superiores
          Positioned(
            top: 34,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$_diasHablar días 💬",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          Positioned(
            top: 34,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.redAccent.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$_diasNovios días ❤️",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Frases
          Positioned(
            bottom: 33,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _fraseActual,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}