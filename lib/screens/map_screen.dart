import 'package:flutter/material.dart';

// 👇 Modelo de nodo (puedes moverlo luego a models/node.dart si quieres)
class Node {
  final String name;
  final double lat;
  final double lng;
  final String mission;

  Node(this.name, this.lat, this.lng, this.mission);
}

// 👇 Lista de nodos (la de Felipe)
List<Node> nodes = [
  Node("Nodo Alpha", 4.705, -74.231, "Escanear prenda"),
  Node("Nodo Beta", 4.710, -74.230, "Guardar outfit"),
];

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa de misiones 🗺️"),
      ),
      body: ListView.builder(
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          final node = nodes[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.location_on, color: Colors.blue),
              title: Text(node.name),
              subtitle: Text(node.mission),
              trailing: Text(
                "${node.lat}, ${node.lng}",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}