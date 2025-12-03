import 'package:flutter/material.dart';

class CreateProjectScreen extends StatelessWidget {
  const CreateProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4B0082), // gradientTop
            Color(0xFF5E35B1), // gradientMiddle
            Color(0xFF009688), // Soft Cream
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}