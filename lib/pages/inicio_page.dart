import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/fondo_dinamico.dart'; // 👈 importa el widget de fondo dinámico

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
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

  final PageController _pageController = PageController();
  int _currentPage = 0;

  String _fraseActual = "";
  late Timer _timerFrases;
  late Timer _timerImagenes;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _cambiarFrase();

    // cambiar frase cada 5 segundos
    _timerFrases = Timer.periodic(const Duration(seconds: 5), (timer) {
      _cambiarFrase();
    });

    // cambiar imagen cada 3 segundos
    _timerImagenes = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _imagenes.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
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

  @override
  void dispose() {
    _timerFrases.cancel();
    _timerImagenes.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FondoDinamico(
      tipo: "inicio", // 👈 usamos el fondo dinámico para esta pantalla
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _imagenes.length,
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
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
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(12),
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
}