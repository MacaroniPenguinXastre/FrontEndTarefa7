import 'package:flutter/material.dart';

class RealizarTestePage extends StatelessWidget {
  const RealizarTestePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Teste de Aptidão'),
      ),
      body: SafeArea(
        child: Center(
          child: const Text('Página de Teste de Aptidão'),
        ),
      ),
    );
  }
}
