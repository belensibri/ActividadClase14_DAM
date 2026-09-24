import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/carrito_notifier.dart';

/// Lee el carrito compartido sin recibir productos ni total por constructor.
class ResumenScreen extends StatelessWidget {
  const ResumenScreen({super.key});

  void _mostrarConfirmacion(BuildContext context) {
    final carrito = context.read<CarritoNotifier>();
    if (!carrito.puedeContinuar) return;

    final totalPagado = carrito.total;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Compra exitosa'),
        content: Text('Total pagado: \$${totalPagado.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumen de compra')),
      body: Consumer<CarritoNotifier>(
        builder: (context, carrito, child) {
          final seleccionados = carrito.seleccionados;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final producto in seleccionados)
                ListTile(
                  title: Text(producto.nombre),
                  trailing: Text('\$${producto.precio.toStringAsFixed(2)}'),
                ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  '\$${carrito.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              if (!carrito.puedeContinuar)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text('Selecciona exactamente 3 productos en el catálogo.'),
                ),
              ElevatedButton(
                onPressed: carrito.puedeContinuar
                    ? () => _mostrarConfirmacion(context)
                    : null,
                child: const Text('Proceder a pagar'),
              ),
            ],
          );
        },
      ),
    );
  }
}
