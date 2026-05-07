import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../models/node.dart';

class LocationTest extends StatefulWidget {
  const LocationTest({super.key});

  @override
  State<LocationTest> createState() => _LocationTestState();
}

class _LocationTestState extends State<LocationTest> {

  final locationService = LocationService();
  String result = "Cargando...";

  @override
  void initState() {
    super.initState();
    checkNodes();
  }

  void checkNodes() async {
    final pos = await locationService.getPosition();

    List<String> nearby = [];

    for (var node in nodes) {
      double distance = locationService.calculateDistance(
        pos.latitude,
        pos.longitude,
        node.lat,
        node.lng,
      );

      if (distance < 500) {
        nearby.add(node.name);
      }
    }

    setState(() {
      result = nearby.isEmpty
          ? "No hay nodos cerca"
          : "Nodos cercanos: ${nearby.join(", ")}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(result)),
    );
  }
}