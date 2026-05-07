import 'package:flutter/material.dart';
import '../widgets/typing_text.dart';

class TerminalScreen extends StatelessWidget {
  const TerminalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHADOWNET"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.green.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: TypingText(
            text:
                "> Inicializando sistema...\n"
                "> Conectando...\n"
                "> Acceso concedido ✔\n"
                "> Bienvenido usuario\n",
          ),
        ),
      ),
    );
  }
}