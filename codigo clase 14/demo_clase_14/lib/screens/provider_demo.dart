import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/demo_scaffold.dart';
import '../shared/theme.dart';

/// Clase 14 — Diapositiva 5-6: el paquete Provider.
/// Un ChangeNotifier expuesto con ChangeNotifierProvider y consumido con
/// Consumer desde dos paneles — y una comparación explícita entre
/// context.watch (se suscribe, reconstruye) y context.read (lee una vez,
/// pensado para usarse dentro de callbacks como onPressed).
class ContadorNotifier extends ChangeNotifier {
  int _valor = 0;
  int get valor => _valor;

  void incrementar() {
    _valor++;
    notifyListeners();
  }
}

class ProviderDemo extends StatelessWidget {
  const ProviderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContadorNotifier(),
      child: DemoScaffold(
        title: 'Provider: ChangeNotifier y Consumer',
        nota:
            'Ambos paneles leen el mismo ContadorNotifier a través de Provider. '
            'El botón de cada panel usa context.read (correcto dentro de '
            'onPressed); el texto que se actualiza solo usa context.watch, '
            'dentro de Consumer.',
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(child: _PanelProvider(nombre: 'Pantalla A')),
                  SizedBox(width: 16),
                  Expanded(child: _PanelProvider(nombre: 'Pantalla B')),
                ],
              ),
              const SizedBox(height: 24),
              const DemoSection(
                titulo: 'context.watch vs. context.read',
                child: Text(
                  'watch(): se suscribe a los cambios — úselo dentro de build() '
                  'para que el widget se reconstruya cuando notifyListeners() se '
                  'dispare. read(): lee el valor una sola vez, sin suscribirse — '
                  'úselo dentro de callbacks (onPressed, onTap), nunca en build(), '
                  'porque ahí no reaccionaría a cambios futuros.',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelProvider extends StatelessWidget {
  final String nombre;
  const _PanelProvider({required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: kNavySoft, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold, color: kNavy)),
          const SizedBox(height: 8),
          // Consumer + context.watch: se reconstruye cuando notifyListeners() ocurre.
          Consumer<ContadorNotifier>(
            builder: (context, contador, _) {
              return Text('${contador.valor}', style: const TextStyle(fontSize: 32, color: kNavy));
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            // context.read dentro de onPressed: lee el notifier una sola vez
            // para llamar un método, sin suscribirse a cambios futuros aquí.
            onPressed: () => context.read<ContadorNotifier>().incrementar(),
            child: const Text('+1 (Provider)'),
          ),
        ],
      ),
    );
  }
}
