import 'package:flutter/material.dart';

import 'shared/theme.dart';
import 'screens/local_setstate_limit_demo.dart';
import 'screens/inherited_widget_demo.dart';
import 'screens/provider_demo.dart';
import 'screens/lifting_state_up_demo.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Clase 14',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeScreen(),
    );
  }
}

class _DemoItem {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final WidgetBuilder builder;

  const _DemoItem({
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.builder,
  });
}

final List<_DemoItem> _items = [
  _DemoItem(
    titulo: 'El límite de setState local',
    subtitulo: 'Dos pantallas independientes: incrementar una no afecta a la otra',
    icono: Icons.block,
    builder: (_) => const LocalSetStateLimitDemo(),
  ),
  _DemoItem(
    titulo: 'InheritedWidget en acción',
    subtitulo: 'Un contador compartido sin pasarlo por constructor',
    icono: Icons.account_tree_outlined,
    builder: (_) => const InheritedWidgetDemo(),
  ),
  _DemoItem(
    titulo: 'Provider: ChangeNotifier y Consumer',
    subtitulo: 'context.watch frente a context.read',
    icono: Icons.hub_outlined,
    builder: (_) => const ProviderDemo(),
  ),
  _DemoItem(
    titulo: 'Elevación de estado vs. Provider',
    subtitulo: 'La misma jerarquía de tres niveles, con y sin "callback hell"',
    icono: Icons.compare_arrows,
    builder: (_) => const LiftingStateUpDemo(),
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo: Clase 14')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'De InheritedWidget a Provider',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kNavy),
                ),
                Text(
                  'Introducción a la gestión de estado compartido',
                  style: TextStyle(fontSize: 12, color: kNavy),
                ),
              ],
            ),
          ),
          for (final item in _items)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ListTile(
                leading: CircleAvatar(backgroundColor: kNavySoft, child: Icon(item.icono, color: kNavy)),
                title: Text(item.titulo),
                subtitle: Text(item.subtitulo),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: item.builder)),
              ),
            ),
        ],
      ),
    );
  }
}
