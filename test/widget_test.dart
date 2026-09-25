import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:actividad_clase_14_dam/main.dart';
import 'package:actividad_clase_14_dam/providers/carrito_notifier.dart';

void main() {
  testWidgets('Carga el catalogo y actualiza la cantidad seleccionada', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CarritoNotifier(),
        child: const MyApp(),
      ),
    );

    expect(find.text('Catálogo de productos'), findsOneWidget);
    expect(find.text('0 de 3 seleccionados'), findsOneWidget);

    await tester.tap(find.text('Cuaderno'));
    await tester.pump();

    expect(find.text('1 de 3 seleccionados'), findsOneWidget);
  });
}
