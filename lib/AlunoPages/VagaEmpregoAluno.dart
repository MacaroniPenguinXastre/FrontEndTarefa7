import 'package:flutter/material.dart';

class VagaEmpregoAlunoTela extends StatefulWidget {
  const VagaEmpregoAlunoTela({Key? key}) : super(key: key);

  @override
  _VagaEmpregoAlunoTelaState createState() => _VagaEmpregoAlunoTelaState();
}

class _VagaEmpregoAlunoTelaState extends State<VagaEmpregoAlunoTela> {
  String selectedOption = "";

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
              items: const [
                DropdownMenuItem<String>(
                  value: 'treinamento1',
                  child: Text('Treinamento 1'),
                ),
                DropdownMenuItem<String>(
                  value: 'treinamento2',
                  child: Text('Treinamento 2'),
                ),
                DropdownMenuItem<String>(
                  value: 'treinamento3',
                  child: Text('Treinamento 3'),
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value!;
                });
              },
              value: selectedOption,
              hint: const Text('Selecione um treinamento'),
              isExpanded: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedOption.isNotEmpty
                  ? () {
                // Lógica para navegar para outra página
              }
                  : null,
              child: const Text('Visitar a Página'),
            ),
          ],
        ),
      ),
    );
  }
}
