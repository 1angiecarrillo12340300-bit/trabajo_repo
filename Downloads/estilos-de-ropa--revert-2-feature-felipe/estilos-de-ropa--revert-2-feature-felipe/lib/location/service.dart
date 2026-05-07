import 'package:geolocator/geolocator.dart';

/// Servicio encargado de gestionar la ubicación del usuario.
///
/// Funciones principales:
/// - Verificar si el GPS está activo.
/// - Solicitar permisos de ubicación.
/// - Obtener la posición actual.
/// - Calcular distancias entre coordenadas.
class LocationService {

  /// Obtiene la posición actual del usuario.
  ///
  /// Primero verifica:
  /// - si el servicio de ubicación está activado,
  /// - si la aplicación tiene permisos.
  ///
  /// Retorna:
  /// - un objeto [Position] con latitud y longitud.
  ///
  /// Lanza una excepción si:
  /// - la ubicación está desactivada.
  Future<Position> getPosition() async {

    /// Verifica si el GPS está activo
    bool serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("Ubicación desactivada");
    }

    /// Verifica permisos de ubicación
    LocationPermission permission =
        await Geolocator.checkPermission();

    /// Solicita permisos si fueron denegados
    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
    }

    /// Obtiene la posición actual del dispositivo
    return await Geolocator.getCurrentPosition();
  }

  /// Calcula la distancia entre dos coordenadas.
  ///
  /// Parámetros:
  /// - [lat1] Latitud punto inicial
  /// - [lon1] Longitud punto inicial
  /// - [lat2] Latitud punto destino
  /// - [lon2] Longitud punto destino
  ///
  /// Retorna:
  /// - la distancia en metros.
  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {

    return Geolocator.distanceBetween(
      lat1,
      lon1,
      lat2,
      lon2,
    );
  }
}