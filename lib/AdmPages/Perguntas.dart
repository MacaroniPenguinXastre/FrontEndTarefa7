import 'package:flutter/material.dart';

import '../model/User.dart';

class PerguntasTelaADM extends StatelessWidget {
  final User loggedUser;
  const PerguntasTelaADM({Key? key, required this.loggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CriarPerguntaPage(loggedUser: loggedUser),
                  ),
                );
              },
              child: const Text('Criar Pergunta'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeletarPerguntaPage(loggedUser: loggedUser),
                  ),
                );
              },
              child: const Text('Deletar Pergunta'),
            ),
          ],
        ),
      ),
    );
  }
}

class CriarPerguntaPage extends StatelessWidget {
  final User loggedUser;
  const CriarPerguntaPage({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Pergunta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Enunciado'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Alternativa A'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Alternativa B'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Alternativa C'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Alternativa D'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Alternativa E'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              items: ['A', 'B', 'C', 'D', 'E']
                  .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
                  .toList(),
              onChanged: (value) {
                // Aqui você pode salvar a alternativa correta selecionada
              },
              decoration: const InputDecoration(
                labelText: 'Selecione a Alternativa Correta',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode realizar a lógica para criar a pergunta
              },
              child: const Text('Criar Pergunta'),
            ),
          ],
        ),
      ),
    );
  }
}

class DeletarPerguntaPage extends StatelessWidget {
  final User loggedUser;
  const DeletarPerguntaPage({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deletar Pergunta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField<String>(
              items: ['Pergunta 1', 'Pergunta 2', 'Pergunta 3']
                  .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
                  .toList(),
              onChanged: (value) {
                // Aqui você pode salvar a pergunta selecionada para exclusão
              },
              decoration: const InputDecoration(
                labelText: 'Selecione a Pergunta',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode realizar a lógica para deletar a pergunta
              },
              child: const Text('Deletar'),
            ),
          ],
        ),
      ),
    );
  }
}


