  import 'dart:math';

  import 'package:flutter/material.dart';
  import 'package:login_page/model/User.dart';

  class CursosTelaADM extends StatelessWidget {
    final User loggedUser;

    const CursosTelaADM({Key? key, required this.loggedUser}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Página Inicial'),
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
                        builder: (context) => CriarCursoPage(loggedUser: loggedUser),
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
                    'Criar Curso',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: 200.0,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeletarCursoPage(loggedUser: loggedUser),
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
                    'Deletar Curso',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: 200.0,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodosCursosPage(loggedUser: loggedUser),
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
                    'Exibir todos os Cursos',
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

  class CriarCursoPage extends StatelessWidget {
    final User loggedUser;
    const CriarCursoPage({Key? key, required this.loggedUser}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Criar Curso'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Conteúdo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para criar o curso
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Criar Curso',
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

  class DeletarCursoPage extends StatelessWidget {
    final User loggedUser;
    const DeletarCursoPage({Key? key, required this.loggedUser}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Deletar Curso'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButton<String>(
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Curso 1',
                    child: Text('Curso 1'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Curso 2',
                    child: Text('Curso 2'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Curso 3',
                    child: Text('Curso 3'),
                  ),
                ],
                onChanged: (value) {
                  // Lógica para selecionar o curso
                },
                hint: const Text('Selecione um curso'),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para deletar o curso
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

  class TodosCursosPage extends StatelessWidget {
    final User loggedUser;
    final List<String> cursos = [
      'Curso 1',
      'Curso 2',
      'Curso 3',
      'Curso 4',
      'Curso 5',
    ];

    TodosCursosPage({Key? key, required this.loggedUser}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Todos os Cursos'),
        ),
        body: ListView.builder(
          itemCount: cursos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                cursos[index],
                style: const TextStyle(fontSize: 18.0),
              ),
              leading: const Icon(
                Icons.book,
                size: 30.0,
              ),
            );
          },
        ),
      );
    }
  }
