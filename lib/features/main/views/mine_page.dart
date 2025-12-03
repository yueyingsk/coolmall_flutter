
import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mine Page'),
      ),
      body: const Center(
        child: Text('Mine Page'),
      ),
    );
  }
}