import 'package:flutter/material.dart';
import '../model/User.dart';

class QuizTelaADM extends StatelessWidget {
  final User loggedUser;

  const QuizTelaADM({Key? key, required this.loggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CriarQuizPage(loggedUser: loggedUser),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Criar Quiz',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 200.0,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeletarQuizPage(loggedUser: loggedUser),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Deletar Quiz',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CriarQuizPage extends StatefulWidget {
  final User loggedUser;
  const CriarQuizPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _CriarQuizPageState createState() => _CriarQuizPageState();
}

class _CriarQuizPageState extends State<CriarQuizPage> {
  List<String> perguntas = ['Pergunta 1'];
  List<String> opcoes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criação de Quiz'),
      ),
      body: SingleChildScrollView( // Adicionado SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Título do Quiz',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: perguntas.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          DropdownButton<String>(
                            items: perguntas
                                .map((pergunta) => DropdownMenuItem<String>(
                              value: pergunta,
                              child: Text(pergunta),
                            ))
                                .toList(),
                            onChanged: (value) {},
                            hint: const Text('Selecione uma pergunta'),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          perguntas.add('Pergunta ${perguntas.length + 1}');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        '+ Adicionar Pergunta',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para criar o quiz
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Criar Quiz',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeletarQuizPage extends StatelessWidget {
  final User loggedUser;
  const DeletarQuizPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deletar Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              items: const [
                DropdownMenuItem<String>(
                  value: 'Quiz 1',
                  child: Text('Quiz 1'),
                ),
                DropdownMenuItem<String>(
                  value: 'Quiz 2',
                  child: Text('Quiz 2'),
                ),
                DropdownMenuItem<String>(
                  value: 'Quiz 3',
                  child: Text('Quiz 3'),
                ),
              ],
              onChanged: (value) {
                // Lógica para selecionar o quiz
              },
              hint: const Text('Selecione um quiz'),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para deletar o quiz
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Deletar',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
