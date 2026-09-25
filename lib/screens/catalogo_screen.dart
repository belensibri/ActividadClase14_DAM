import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/carrito_notifier.dart';
import 'resumen_screen.dart';

/// Muestra el catálogo y permite seleccionar exactamente tres productos.
class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de productos')),
      body: Consumer<CarritoNotifier>(
        builder: (context, carrito, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '${carrito.cantidadSeleccionada} de '
                      '${CarritoNotifier.limiteSeleccion} seleccionados',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    const Text('Selecciona exactamente 3 productos'),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: carrito.productos.length,
                  itemBuilder: (context, index) {
                    final producto = carrito.productos[index];
                    final estaSeleccionado =
                        carrito.estaSeleccionado(producto);
                    final puedeSeleccionarse =
                        carrito.cantidadSeleccionada <
                            CarritoNotifier.limiteSeleccion ||
                        estaSeleccionado;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: CheckboxListTile(
                        title: Text(producto.nombre),
                        subtitle: Text(
                          '\$${producto.precio.toStringAsFixed(2)}',
                        ),
                        value: estaSeleccionado,
                        onChanged: puedeSeleccionarse
                            ? (_) => context
                                .read<CarritoNotifier>()
                                .alternarSeleccion(producto)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: carrito.puedeContinuar
                        ? () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const ResumenScreen(),
                              ),
                            )
                        : null,
                    child: const Text('Ver resumen de compra'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
