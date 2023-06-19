import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/AlunoPages/AlunoAccess.dart';
import 'package:login_page/model/Treinamento.dart';

import '../model/User.dart';
import '../model/Values.dart';

class VagaEmpregoAlunoTela extends StatefulWidget {
  final User loggedUser;
  const VagaEmpregoAlunoTela({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _VagaEmpregoAlunoTelaState createState() => _VagaEmpregoAlunoTelaState();
}

class _VagaEmpregoAlunoTelaState extends State<VagaEmpregoAlunoTela> {
  String? selectedOption;
  List<Treinamento> treinamentoList = [];

  @override
  void initState() {
    getTreinamentos();
    super.initState();
  }

  void getTreinamentos()async{
    final Uri URL = Uri.parse('$mainURL/treinamentos/available');


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinamentos'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TreinamentoPage(loggedUser: widget.loggedUser),
                  ),
                );
              },
              child: const Text('Visitar a Página'),
            ),
          ],
        ),
      ),
    );
  }
}

class TreinamentoPage extends StatelessWidget {
  final User loggedUser;
  const TreinamentoPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Titulo do Treinamento'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Eyes go shut\n"
                      "I dissipate\n"
                  // Resto do texto...
                      "Stuck here with you and my soul on display",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para inscrição no treinamento
                  },
                  child: const Text('Quero me Inscrever'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
