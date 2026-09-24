import 'package:flutter/material.dart';
import '../shared/demo_scaffold.dart';
import '../shared/theme.dart';

/// Clase 14 — Diapositiva 3: el límite de setState local.
/// Dos "pantallas" representadas como paneles independientes, cada una con
/// su propio contador manejado con setState local. Pida a la clase que
/// prediga, antes de tocar los botones, si incrementar el panel A afecta
/// al panel B.
class LocalSetStateLimitDemo extends StatelessWidget {
  const LocalSetStateLimitDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'El límite de setState local',
      nota:
          'Cada panel de abajo es una "pantalla" independiente con su propio '
          'contador local. Incremente el panel A y observe el panel B: no '
          'cambia. Esa es exactamente la limitación que InheritedWidget y '
          'Provider van a resolver en el resto de la clase.',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: const [
            Expanded(child: _PanelIndependiente(nombre: 'Pantalla A')),
            SizedBox(width: 16),
            Expanded(child: _PanelIndependiente(nombre: 'Pantalla B')),
          ],
        ),
      ),
    );
  }
}

class _PanelIndependiente extends StatefulWidget {
  final String nombre;
  const _PanelIndependiente({required this.nombre});

  @override
  State<_PanelIndependiente> createState() => _PanelIndependienteState();
}

class _PanelIndependienteState extends State<_PanelIndependiente> {
  int _contador = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: kNavySoft, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.nombre, style: const TextStyle(fontWeight: FontWeight.bold, color: kNavy)),
          const SizedBox(height: 8),
          Text('$_contador', style: const TextStyle(fontSize: 32, color: kNavy)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setState(() => _contador++),
            child: const Text('+1 (setState local)'),
          ),
        ],
      ),
    );
  }
}
