import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../models/node.dart';

/// Pantalla de prueba para validar la detección
/// de nodos cercanos usando la ubicación del usuario.
class LocationTest extends StatefulWidget {

  /// Constructor principal del widget
  const LocationTest({super.key});

  @override
  State<LocationTest> createState() =>
      _LocationTestState();
}

/// Estado del widget LocationTest
class _LocationTestState
    extends State<LocationTest> {

  /// Instancia del servicio de ubicación
  final locationService = LocationService();

  /// Texto que se mostrará en pantalla
  String result = "Cargando...";

  /// Método que se ejecuta al iniciar la pantalla
  @override
  void initState() {
    super.initState();

    /// Inicia la validación de nodos cercanos
    checkNodes();
  }

  /// Verifica qué nodos están cerca del usuario.
  ///
  /// Flujo:
  /// 1. Obtiene la ubicación actual.
  /// 2. Recorre todos los nodos.
  /// 3. Calcula la distancia.
  /// 4. Guarda los nodos cercanos.
  /// 5. Actualiza la interfaz.
  void checkNodes() async {

    /// Obtiene la posición actual del usuario
    final pos =
        await locationService.getPosition();

    /// Lista de nodos cercanos encontrados
    List<String> nearby = [];

    /// Recorre todos los nodos disponibles
    for (var node in nodes) {

      /// Calcula distancia entre usuario y nodo
      double distance =
          locationService.calculateDistance(
        pos.latitude,
        pos.longitude,
        node.lat,
        node.lng,
      );

      /// Verifica si el nodo está
      /// a menos de 500 metros
      if (distance < 500) {

        /// Agrega el nombre del nodo
        nearby.add(node.name);
      }
    }

    /// Actualiza la interfaz visual
    setState(() {

      /// Muestra mensaje dependiendo
      /// de si existen nodos cercanos
      result = nearby.isEmpty
          ? "No hay nodos cerca"
          : "Nodos cercanos: ${nearby.join(", ")}";
    });
  }

  /// Construcción de la interfaz visual
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /// Contenido principal centrado
      body: Center(

        /// Muestra el resultado actual
        child: Text(result),
      ),
    );
  }
}