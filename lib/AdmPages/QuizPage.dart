import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/AlunoPages/AlunoAccess.dart';

import 'package:login_page/model/Curso.dart';
import 'package:login_page/model/User.dart';
import 'package:login_page/model/Values.dart';

import '../model/Pergunta.dart';
import '../model/Quiz.dart';

class QuizTelaADM extends StatelessWidget {
  final User loggedUser;

  const QuizTelaADM({Key? key, required this.loggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      builder: (context) => CreateQuizPage(loggedUser: loggedUser),
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
                  'Criar quiz',
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
                      builder: (context) => TodosQuizzesPage(loggedUser: loggedUser),
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
                  'Exibir todos os Quiz',
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

class CreateQuizPage extends StatefulWidget {

  final User loggedUser;
  const CreateQuizPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final TextEditingController tituloController = TextEditingController();
  List<Pergunta> perguntasList = [];
  List<Pergunta> selectedPergunta = [];


  void getPerguntas() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/perguntas'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        perguntasList = jsonResponse.map((json) => Pergunta.fromJson(json)).toList();
      });

    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getPerguntas();
    super.initState();
  }

  void sendQuiz(BuildContext context)async{

    final URL = Uri.parse('$mainURL/quizzes');
    RegisterQuiz registerQuiz = RegisterQuiz(tituloController.text, selectedPergunta, widget.loggedUser);
    String jsonQuiz = jsonEncode(registerQuiz.toJson());

    try{
      http.Response response = await http.post(URL,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonQuiz);

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Quiz cadastrado!'),
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
        title: const Text('Cadastre um Quiz'),
      ),
      body: ListView(
          children:[
            Padding(
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

                  ListView.builder(
                    itemCount: perguntasList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Pergunta pergunta = perguntasList[index];
                      return ListTile(
                        leading: Text('${pergunta.id}'),
                        title: Text(pergunta.enunciado),
                        subtitle: Text('Gabarito: ${pergunta.alternativaCorreta}'),
                        trailing: Checkbox(
                          value: selectedPergunta.contains(pergunta),
                          onChanged: (bool? newValue){
                            setState(() {
                              newValue = !selectedPergunta.contains(pergunta);
                              if(newValue == true){
                                selectedPergunta.add(pergunta);
                              }
                              else{
                                selectedPergunta.remove(pergunta);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed:()=> sendQuiz(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
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
          ]
      ),
    );
  }
}


class TodosQuizzesPage extends StatefulWidget {
  final User loggedUser;
  const TodosQuizzesPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _TodosQuizzesPageState createState() => _TodosQuizzesPageState();
}

class _TodosQuizzesPageState extends State<TodosQuizzesPage> {
  List<Quiz> quizList = [];

  void getQuizzes() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/quizzes'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        quizList = jsonResponse.map((json) => Quiz.fromJson(json)).toList();
      });
    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getQuizzes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Quiz'),
      ),
      body: ListView.builder(
      itemCount: quizList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Quiz quiz = quizList[index];
        return ListTile(
          leading: Text('${quiz.id}'),
          title: Text(quiz.titulo),
          subtitle: Text('Quantidade de perguntas associadas: ${quiz.perguntas.length}'),
        );
      },
    ),
    );
  }
}

