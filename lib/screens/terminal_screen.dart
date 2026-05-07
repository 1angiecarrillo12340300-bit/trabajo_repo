import 'package:flutter/material.dart';

class TerminalScreen extends StatelessWidget {
  const TerminalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHADOWNET"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "> Inicializando sistema...\n"
          "> Conectando...\n"
          "> Acceso concedido ✔\n"
          "> Bienvenido usuario\n",
        ),
      ),
    );
  }
}