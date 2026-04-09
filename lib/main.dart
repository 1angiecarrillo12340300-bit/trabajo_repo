// Importa los widgets básicos de Flutter (UI, temas, etc.)
import 'package:flutter/material.dart';

// Importa Provider para manejo de estado global
import 'package:provider/provider.dart';

// Importa el proveedor donde se maneja la lógica de la app (ropa)
import 'providers/wardrobe_provider.dart';

// Importa la pantalla principal (cámara)
import 'screens/camera_screen.dart';

/// Punto de entrada principal de la aplicación
void main() {
  runApp(
    // ChangeNotifierProvider permite compartir el estado en toda la app
    ChangeNotifierProvider(
      // Se crea una instancia del provider (gestiona datos y lógica)
      create: (_) => WardrobeProvider(),

      // MyApp será el widget raíz que tendrá acceso al provider
      child: const MyApp(),
    ),
  );
}

/// Widget principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Quita la etiqueta de "debug" en la esquina
      debugShowCheckedModeBanner: false,

      // Define la pantalla inicial de la app
      home: CameraScreen(),
    );
  }
}