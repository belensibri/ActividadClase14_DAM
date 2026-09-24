# Demo — Clase 14

App Flutter de un solo propósito: apoyar en vivo la explicación de la
Clase 14 de Desarrollo de Aplicaciones Móviles (de InheritedWidget a
Provider: introducción a la gestión de estado compartido). No es una app
de producción ni el proyecto integrador del curso (ese es ServiFácil) —
es material docente para hacer hot-reload en vivo frente a la clase.

## Cómo abrirla

Este paquete trae solo `pubspec.yaml`, `analysis_options.yaml` y `lib/`
(sin las carpetas `android/`, `ios/`, `web/`, etc.), para mantenerlo liviano.

1. Cree un proyecto Flutter nuevo con las carpetas de plataforma:
   ```
   flutter create demo_clase_14
   ```
2. Reemplace el `pubspec.yaml` y la carpeta `lib/` generados por los de
   este paquete (sobrescriba ambos).
3. Instale las dependencias y ejecute:
   ```
   cd demo_clase_14
   flutter pub get
   flutter run
   ```

Esta app agrega una dependencia real, el paquete `provider` (`^6.1.2`),
declarada en `pubspec.yaml`. `flutter pub get` debe descargarla antes de
ejecutar la app.

## Qué contiene

- **El límite de setState local**: dos paneles independientes ("Pantalla
  A" y "Pantalla B"), cada uno con su propio contador y su propio
  `setState`. Sirve para que la clase compruebe que incrementar uno no
  afecta al otro, antes de introducir una solución compartida.
- **InheritedWidget en acción**: una implementación mínima de
  `InheritedWidget` (`ContadorInherited`) que expone un contador a dos
  paneles mediante `.of(context)`, sin pasarlo por constructor. Ilustra la
  reconstrucción selectiva: solo los widgets que dependen del valor se
  reconstruyen cuando cambia.
- **Provider: ChangeNotifier y Consumer**: un `ChangeNotifier`
  (`ContadorNotifier`) expuesto con `ChangeNotifierProvider` y consumido
  por dos paneles con `Consumer`. Contrasta explícitamente `context.watch`
  (dentro de `build()`, para reconstruir) con `context.read` (dentro de
  callbacks como `onPressed`, para leer una vez).
- **Elevación de estado vs. Provider**: la misma jerarquía de tres
  niveles, alternable con un `SegmentedButton`. En modo "Elevación de
  estado", el nivel intermedio recibe el contador y el callback solo para
  reenviarlos ("callback hell"); en modo "Provider", el nivel intermedio
  no recibe ni pasa nada.

## Nota

No se validó con `flutter analyze` / `flutter test` en este entorno (no
hay SDK de Flutter instalado aquí); revise ambos comandos —incluida la
resolución de la dependencia `provider`— antes de usarla en clase, como
con cualquier material nuevo.
