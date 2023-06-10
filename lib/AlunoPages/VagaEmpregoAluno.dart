import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/AlunoPages/AlunoAccess.dart';

import '../model/user.dart';

class VagaEmpregoAlunoTela extends StatefulWidget {
  final User loggedUser;
  const VagaEmpregoAlunoTela({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _VagaEmpregoAlunoTelaState createState() => _VagaEmpregoAlunoTelaState();
}

class _VagaEmpregoAlunoTelaState extends State<VagaEmpregoAlunoTela> {
  String? selectedOption;
  List<String> treinamentos = [];

  @override
  void initState() {
    super.initState();
    fetchTreinamentos();
  }

  Future<void> fetchTreinamentos() async {
    try {
      final response = await http.get(Uri.parse('https://456c-2804-14c-487-1bd2-00-1b95.ngrok-free.app/treinamentos/available'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('$data');

        setState(() {
          treinamentos = List<String>.from(data);
        });
      } else {
        print('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
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
            DropdownButton<String>(
              value: selectedOption,
              items: treinamentos.map((treinamento) {
                return DropdownMenuItem<String>(
                  value: treinamento,
                  child: Text(treinamento),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value;
                });
              },
              hint: const Text('Selecione um treinamento'),
              isExpanded: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Treinamento(loggedUser: widget.loggedUser),
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

class Treinamento extends StatelessWidget {
  final User loggedUser;
  const Treinamento({Key? key, required this.loggedUser}) : super(key: key);

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
