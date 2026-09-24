import 'package:flutter/foundation.dart';

import '../models/producto.dart';

/// Estado compartido que las pantallas consumiran mediante Provider.
class CarritoNotifier extends ChangeNotifier {
  static const int limiteSeleccion = 3;

  final List<Producto> productos = const [
    Producto(id: 1, nombre: 'Cuaderno', precio: 2.50),
    Producto(id: 2, nombre: 'Lapicero', precio: 0.75),
    Producto(id: 3, nombre: 'Mochila', precio: 18.00),
    Producto(id: 4, nombre: 'Regla', precio: 1.25),
    Producto(id: 5, nombre: 'Colores', precio: 4.50),
  ];

  final List<Producto> _seleccionados = [];

  // Evita que una pantalla modifique el carrito sin notifyListeners().
  List<Producto> get seleccionados => List.unmodifiable(_seleccionados);

  int get cantidadSeleccionada => _seleccionados.length;

  bool get puedeContinuar => cantidadSeleccionada == limiteSeleccion;

  double get total => _seleccionados.fold<double>(
    0,
    (suma, producto) => suma + producto.precio,
  );

  bool estaSeleccionado(Producto producto) => _seleccionados.contains(producto);

  /// Recibe un producto de [productos]; agrega o quita su seleccion.
  /// Ignora productos ajenos al catalogo y un cuarto producto adicional.
  void alternarSeleccion(Producto producto) {
    if (!productos.contains(producto)) return;

    if (estaSeleccionado(producto)) {
      _seleccionados.remove(producto);
    } else {
      if (cantidadSeleccionada >= limiteSeleccion) return;
      _seleccionados.add(producto);
    }

    notifyListeners();
  }
}
