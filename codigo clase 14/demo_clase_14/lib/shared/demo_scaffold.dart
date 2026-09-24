import 'package:flutter/material.dart';
import 'theme.dart';

/// Estructura común de cada pantalla-demo: AppBar con el título del
/// concepto, una tarjeta con la "nota pedagógica" (qué observar / qué
/// preguntar a la clase) y el área interactiva propiamente dicha.
class DemoScaffold extends StatelessWidget {
  final String title;
  final String nota;
  final Widget child;
  final List<Widget>? actions;

  const DemoScaffold({
    super.key,
    required this.title,
    required this.nota,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            color: kNavySoft,
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb_outline, color: kNavy),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    nota,
                    style: const TextStyle(color: kNavy, fontSize: 13, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Tarjeta de sección reutilizable para separar bloques dentro de una demo.
class DemoSection extends StatelessWidget {
  final String titulo;
  final Widget child;

  const DemoSection({super.key, required this.titulo, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold, color: kNavy, fontSize: 15),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
