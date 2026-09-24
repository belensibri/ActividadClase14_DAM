import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/demo_scaffold.dart';
import '../shared/theme.dart';
import 'provider_demo.dart' show ContadorNotifier;

/// Clase 14 — Diapositiva 7: elevación de estado (lifting state up) frente
/// a Provider. Misma jerarquía de tres niveles en ambos modos: en
/// "Elevación de estado", el contador y el callback se pasan explícitamente
/// por cada nivel (aunque el nivel intermedio no los use, "callback hell");
/// en "Provider", ningún nivel intermedio recibe ni pasa nada.
class LiftingStateUpDemo extends StatefulWidget {
  const LiftingStateUpDemo({super.key});

  @override
  State<LiftingStateUpDemo> createState() => _LiftingStateUpDemoState();
}

class _LiftingStateUpDemoState extends State<LiftingStateUpDemo> {
  bool _usarProvider = false;
  int _contador = 0;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Elevación de estado vs. Provider',
      nota:
          'Los tres niveles anidados son los mismos en ambos modos. Observe qué '
          'recibe el Nivel 2 (intermedio): en "Elevación de estado" recibe el '
          'contador y el callback solo para reenviarlos — eso es el "callback '
          'hell" que menciona el guion; en "Provider" no recibe nada.',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Elevación de estado')),
                ButtonSegment(value: true, label: Text('Provider')),
              ],
              selected: {_usarProvider},
              onSelectionChanged: (s) => setState(() => _usarProvider = s.first),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _usarProvider
                    ? ChangeNotifierProvider(
                        create: (_) => ContadorNotifier(),
                        child: const _Nivel1Provider(),
                      )
                    : _Nivel1Callback(contador: _contador, onIncrementar: () => setState(() => _contador++)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NivelBox extends StatelessWidget {
  final String etiqueta;
  final Widget hijo;
  const _NivelBox({required this.etiqueta, required this.hijo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: kNavy.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(etiqueta, style: const TextStyle(fontSize: 11, color: kNavy, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          hijo,
        ],
      ),
    );
  }
}

// ------------------------- Modo: elevación de estado -------------------------

class _Nivel1Callback extends StatelessWidget {
  final int contador;
  final VoidCallback onIncrementar;
  const _Nivel1Callback({required this.contador, required this.onIncrementar});

  @override
  Widget build(BuildContext context) {
    return _NivelBox(
      etiqueta: 'Nivel 1 (Root) — dueño del estado',
      hijo: _Nivel2Callback(contador: contador, onIncrementar: onIncrementar),
    );
  }
}

class _Nivel2Callback extends StatelessWidget {
  final int contador;
  final VoidCallback onIncrementar;
  const _Nivel2Callback({required this.contador, required this.onIncrementar});

  @override
  Widget build(BuildContext context) {
    return _NivelBox(
      etiqueta: 'Nivel 2 (intermedio) — recibe contador y onIncrementar solo para reenviarlos',
      hijo: _Nivel3Callback(contador: contador, onIncrementar: onIncrementar),
    );
  }
}

class _Nivel3Callback extends StatelessWidget {
  final int contador;
  final VoidCallback onIncrementar;
  const _Nivel3Callback({required this.contador, required this.onIncrementar});

  @override
  Widget build(BuildContext context) {
    return _NivelBox(
      etiqueta: 'Nivel 3 (hoja) — usa el contador y el callback',
      hijo: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$contador', style: const TextStyle(fontSize: 28, color: kNavy)),
          const SizedBox(height: 4),
          ElevatedButton(onPressed: onIncrementar, child: const Text('+1')),
        ],
      ),
    );
  }
}

// ------------------------------- Modo: Provider -------------------------------

class _Nivel1Provider extends StatelessWidget {
  const _Nivel1Provider();

  @override
  Widget build(BuildContext context) {
    return const _NivelBox(
      etiqueta: 'Nivel 1 (Root) — expone el Provider, no guarda el contador',
      hijo: _Nivel2Provider(),
    );
  }
}

class _Nivel2Provider extends StatelessWidget {
  const _Nivel2Provider();

  @override
  Widget build(BuildContext context) {
    return const _NivelBox(
      etiqueta: 'Nivel 2 (intermedio) — no recibe ni pasa nada',
      hijo: _Nivel3Provider(),
    );
  }
}

class _Nivel3Provider extends StatelessWidget {
  const _Nivel3Provider();

  @override
  Widget build(BuildContext context) {
    return _NivelBox(
      etiqueta: 'Nivel 3 (hoja) — lee el Provider directamente',
      hijo: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<ContadorNotifier>(
            builder: (context, contador, _) => Text('${contador.valor}', style: const TextStyle(fontSize: 28, color: kNavy)),
          ),
          const SizedBox(height: 4),
          ElevatedButton(
            onPressed: () => context.read<ContadorNotifier>().incrementar(),
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }
}
