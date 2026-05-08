import 'package:flutter/material.dart';
import '../services/biometric_service.dart';
import 'home_screen.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final BiometricService _biometricService = BiometricService();
  bool _isLoading = false;
  String message = "🔒 App bloqueada";

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    bool available = await _biometricService.isBiometricAvailable();

    if (!available) {
      setState(() {
        message = "Tu dispositivo no soporta biometría";
      });
    }
  }

  Future<void> _unlock() async {
    setState(() => _isLoading = true);

    bool authenticated = await _biometricService.authenticate();

    setState(() => _isLoading = false);

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      setState(() {
        message = "❌ Falló la autenticación";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Seguridad"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.green, fontSize: 18),
            ),
            const SizedBox(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _unlock,
                    child: const Text("Desbloquear"),
                  ),
          ],
        ),
      ),
    );
  }
}