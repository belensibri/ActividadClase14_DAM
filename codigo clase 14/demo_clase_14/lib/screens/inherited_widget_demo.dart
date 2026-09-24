import 'package:flutter/material.dart';
import '../shared/demo_scaffold.dart';
import '../shared/theme.dart';

/// Clase 14 — Diapositiva 4: InheritedWidget como mecanismo base.
/// Un InheritedWidget mínimo expone un contador compartido a dos paneles
/// que lo consumen con .of(context), sin recibirlo por constructor.
class ContadorInherited extends InheritedWidget {
  final int contador;
  final VoidCallback incrementar;

  const ContadorInherited({
    super.key,
    required this.contador,
    required this.incrementar,
    required super.child,
  });

  static ContadorInherited of(BuildContext context) {
    final resultado = context.dependOnInheritedWidgetOfExactType<ContadorInherited>();
    assert(resultado != null, 'No se encontró un ContadorInherited en el árbol.');
    return resultado!;
  }

  @override
  bool updateShouldNotify(ContadorInherited oldWidget) {
    // Solo se reconstruyen los widgets que dependen de este valor cuando
    // el contador realmente cambia — esa es la eficiencia de InheritedWidget
    // frente a reconstruir todo el subárbol sin necesidad.
    return contador != oldWidget.contador;
  }
}

class InheritedWidgetDemo extends StatefulWidget {
  const InheritedWidgetDemo({super.key});

  @override
  State<InheritedWidgetDemo> createState() => _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  int _contador = 0;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'InheritedWidget en acción',
      nota:
          'El botón "+1" está dentro de la Pantalla A, pero incrementa un '
          'contador que ambos paneles leen con ContadorInherited.of(context) — '
          'ninguno de los dos lo recibe por constructor.',
      child: ContadorInherited(
        contador: _contador,
        incrementar: () => setState(() => _contador++),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: _PanelConBoton(nombre: 'Pantalla A')),
              SizedBox(width: 16),
              Expanded(child: _PanelSoloLectura(nombre: 'Pantalla B')),
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelConBoton extends StatelessWidget {
  final String nombre;
  const _PanelConBoton({required this.nombre});

  @override
  Widget build(BuildContext context) {
    final compartido = ContadorInherited.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: kNavySoft, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold, color: kNavy)),
          const SizedBox(height: 8),
          Text('${compartido.contador}', style: const TextStyle(fontSize: 32, color: kNavy)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: compartido.incrementar,
            child: const Text('+1 (InheritedWidget)'),
          ),
        ],
      ),
    );
  }
}

class _PanelSoloLectura extends StatelessWidget {
  final String nombre;
  const _PanelSoloLectura({required this.nombre});

  @override
  Widget build(BuildContext context) {
    final compartido = ContadorInherited.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: kNavySoft, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold, color: kNavy)),
          const SizedBox(height: 8),
          Text('${compartido.contador}', style: const TextStyle(fontSize: 32, color: kAccent)),
          const SizedBox(height: 8),
          const Text('(solo lectura — sin botón propio)', style: TextStyle(fontSize: 11, color: Colors.black54)),
        ],
      ),
    );
  }
}
