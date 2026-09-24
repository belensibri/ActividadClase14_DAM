/// Producto del catalogo. Sus datos no cambian al seleccionarlo.
class Producto {
  const Producto({
    required this.id,
    required this.nombre,
    required this.precio,
  });

  final int id;
  final String nombre;
  final double precio;
}
