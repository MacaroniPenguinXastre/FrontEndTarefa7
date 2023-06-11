import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/AlunoPages/AlunoAccess.dart';
import 'package:login_page/model/Curso.dart';
import 'package:login_page/model/User.dart';
import 'package:login_page/model/Values.dart';

  class CursosTelaADM extends StatelessWidget {
    final User loggedUser;

    const CursosTelaADM({Key? key, required this.loggedUser}) : super(key: key);

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
                        builder: (context) => CriarCursoPage(loggedUser: loggedUser),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
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
              const SizedBox(height: 16.0),
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
                    backgroundColor: Colors.transparent,
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
              const SizedBox(height: 16.0),
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
                    backgroundColor: Colors.transparent,
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
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    final TextEditingController conteudoController = TextEditingController();

    CriarCursoPage({Key? key, required this.loggedUser}) : super(key: key);

    void sendCurso(BuildContext context)async{
      String titulo = tituloController.text;
      String descricao = descricaoController.text;
      String conteudo = conteudoController.text;
      final URL = Uri.parse('$mainURL/cursos');
      RegisterCurso registerCurso = RegisterCurso(titulo: titulo, descricao: descricao, admCriador: loggedUser, materialDidatico: conteudo);
      String jsonCurso = jsonEncode(registerCurso.toJson());

      try{
        http.Response response = await http.post(URL,
            headers: {'Content-Type': 'application/json; charset=utf-8'}, body: jsonCurso);

        switch(response.statusCode){
          case 200:
            const snackBar = SnackBar(
              content: Text('Curso cadastrado!'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;

          case 400:
            const snackBar = SnackBar(
              content: Text('Requisição inválida: Cheque os campos'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;

          case 502:
            const snackBar = SnackBar(
              content: Text('Campos nulos'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;
        }
      } catch(e){
        if(e is SocketException){
          const snackBar = SnackBar(
            content: Text('Erro de conexão: Verifique sua conexão com o sistema.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }

    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Criar Curso'),
        ),
        body: ListView(
          children:[ Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                 TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                  TextField(
                   controller: descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: conteudoController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Conteúdo didático',
                      border: OutlineInputBorder(),
                    ),
                ),
                  ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed:()=> sendCurso(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
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
          ]
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
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para deletar o curso
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
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

class TodosCursosPage extends StatefulWidget {
  final User loggedUser;

  const TodosCursosPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _TodosCursosPageState createState() => _TodosCursosPageState();
}

class _TodosCursosPageState extends State<TodosCursosPage> {
  List<Curso> cursoList = [];

  @override
  void initState() {
    getCursos();
    super.initState();
  }

  void getCursos() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/cursos'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        cursoList = jsonResponse.map((json) => Curso.fromJson(json)).toList();
      });

    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Cursos'),
      ),
      body: ListView.builder(
        itemCount: cursoList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Curso curso = cursoList[index];

          return ListTile(
            leading: Text('${curso.id}'),
            title: Text(curso.titulo),
            subtitle: Text(curso.descricao),
          );
        },
      ),
    );
  }
}

