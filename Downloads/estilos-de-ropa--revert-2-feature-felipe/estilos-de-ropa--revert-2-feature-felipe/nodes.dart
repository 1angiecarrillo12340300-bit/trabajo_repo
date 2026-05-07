/// Modelo que representa un nodo dentro de la aplicación.
/// 
/// Cada nodo contiene:
/// - nombre del nodo
/// - latitud
/// - longitud
/// - misión o tarea asociada
class Node {

  /// Nombre del nodo
  final String name;

  /// Latitud de la ubicación del nodo
  final double lat;

  /// Longitud de la ubicación del nodo
  final double lng;

  /// Misión o acción que debe realizarse en el nodo
  final String mission;

  /// Constructor de la clase Node
  Node(this.name, this.lat, this.lng, this.mission);
}

/// Lista de nodos disponibles en el sistema.
///
/// Cada nodo representa un punto geográfico
/// con una misión específica.
List<Node> nodes = [

  /// Nodo principal Alpha
  Node(
    "Nodo Alpha",
    4.705,
    -74.231,
    "Escanear prenda",
  ),

  /// Nodo secundario Beta
  Node(
    "Nodo Beta",
    4.710,
    -74.230,
    "Guardar outfit",
  ),
];