import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/carrito_notifier.dart';
import 'screens/catalogo_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CarritoNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Actividad Clase 14',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const CatalogoScreen(),
    );
  }
}