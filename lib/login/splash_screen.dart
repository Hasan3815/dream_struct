import 'dart:async';
import 'package:dream_struct/screens/auth_check_screen.dart';
import 'package:dream_struct/screens/auth_gate_screen.dart';
import 'package:dream_struct/screens/role_selection_screen.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthGateScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 40),
            Image.asset(
              "assets/images/house.png",
              width: 300,
            ),
            const Text(
              "Hi, welcome to the wonderful world",
              textAlign: TextAlign.center,
              textScaler: TextScaler.linear(2),
            ),
          ],
        ),
      ),
    );
  }
}