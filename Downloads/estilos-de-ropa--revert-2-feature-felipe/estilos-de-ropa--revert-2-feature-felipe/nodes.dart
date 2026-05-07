class Node {
  final String name;
  final double lat;
  final double lng;
  final String mission;

  Node(this.name, this.lat, this.lng, this.mission);
}

List<Node> nodes = [
  Node("Nodo Alpha", 4.705, -74.231, "Escanear prenda"),
  Node("Nodo Beta", 4.710, -74.230, "Guardar outfit"),
];
