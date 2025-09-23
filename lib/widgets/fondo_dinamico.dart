import 'dart:math';
import 'package:flutter/material.dart';

class FondoDinamico extends StatefulWidget {
  final Widget child;
  final String tipo;
  final PreferredSizeWidget? appBar;

  const FondoDinamico({
    super.key,
    required this.child,
    required this.tipo,
    this.appBar, // puede ser null
  });

  @override
  State<FondoDinamico> createState() => _FondoDinamicoState();
}

class _FondoDinamicoState extends State<FondoDinamico> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final List<_Burbuja> _burbujas = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < 20; i++) {
      _burbujas.add(_Burbuja(
        dx: _random.nextDouble(),
        dy: _random.nextDouble(),
        size: 20 + _random.nextDouble() * 40,
        speed: 0.2 + _random.nextDouble() * 0.5,
        offset: _random.nextDouble() * 2 * pi,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LinearGradient _backgroundGradient(String tipo) {
    switch (tipo) {
      case "inicio":
        return const LinearGradient(
          colors: [Color(0xFFFFF8F0), Color(0xFFFF4B4B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "recuerdos":
        return const LinearGradient(
          colors: [Color(0xFFFFF8F0), Color(0xFFFF4B4B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "cartas":
        return const LinearGradient(
          colors: [Color(0xFFFFF8F0), Color(0xFFFF4B4B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFFFFF8F0), Color(0xFFFF4B4B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo gradient
        Container(
          decoration: BoxDecoration(
            gradient: _backgroundGradient(widget.tipo),
          ),
        ),

        // Burbujas animadas
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => CustomPaint(
            painter: _BurbujaPainter(_burbujas, _controller.value),
            child: Container(),
          ),
        ),

        // AppBar opcional
        if (widget.appBar != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: widget.appBar!,
          ),

        // Contenido debajo
        Padding(
          padding: EdgeInsets.only(top: widget.appBar?.preferredSize.height ?? 0),
          child: widget.child,
        ),
      ],
    );
  }
}

class _Burbuja {
  double dx;
  double dy;
  double size;
  double speed;
  double offset;

  _Burbuja({
    required this.dx,
    required this.dy,
    required this.size,
    required this.speed,
    required this.offset,
  });
}

class _BurbujaPainter extends CustomPainter {
  final List<_Burbuja> burbujas;
  final double animValue;

  _BurbujaPainter(this.burbujas, this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.2);

    for (var b in burbujas) {
      double y = (b.dy + animValue * b.speed) % 1.0;
      double opacity = 0.2 + 0.3 * (0.5 + 0.5 * sin(animValue * 2 * pi + b.offset));
      opacity = opacity.clamp(0.0, 1.0);

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(
        Offset(b.dx * size.width, y * size.height),
        b.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}