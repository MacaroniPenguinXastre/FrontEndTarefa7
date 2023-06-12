import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/model/Curso.dart';
import 'package:login_page/model/Treinamento.dart';
import '../model/Quiz.dart';
import '../model/User.dart';
import '../model/Values.dart';
import 'package:intl/intl.dart';
class TreinamentosTelaADM extends StatelessWidget {
  final User loggedUser;
  TreinamentosTelaADM({Key? key, required this.loggedUser}) : super(key: key);

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
                      builder: (context) => CriarTreinamentoPage(loggedUser: loggedUser),
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
                  'Criar Treinamento',
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
                      builder: (context) => IndexTreinamentoPage(loggedUser: loggedUser),
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
                  'Deletar Treinamento',
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

class CriarTreinamentoPage extends StatefulWidget {
  final User loggedUser;
  const CriarTreinamentoPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _CriarTreinamentoPageState createState() => _CriarTreinamentoPageState();
}

class _CriarTreinamentoPageState extends State<CriarTreinamentoPage> {
  final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
  List<Quiz>quizList = [];
  late Quiz selectedTesteAptidao;
  late Quiz selectedQuizCase1;
  late Quiz selectedQuizCase2;
  

  List<Curso> selectedCursosPrimeiraFase = [];
  List<Curso> selectedCursosSegundaFase = [];
  List<Curso> cursoList = [];

  final TextEditingController cargaHorariaTotalController = TextEditingController();
  final TextEditingController nomeComercialController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController dataInicioInscricaoController = TextEditingController();
  final TextEditingController dataFimInscricaoController = TextEditingController();
  final TextEditingController dataInicioTreinamentoController = TextEditingController();
  final TextEditingController dataFimTreinamentoController = TextEditingController();
  final TextEditingController quantidadeMinimaController = TextEditingController();
  final TextEditingController quantidadeMaximaController = TextEditingController();


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
  void sendTreinamento(BuildContext context)async{
    final URL = Uri.parse('$mainURL/adm/${widget.loggedUser.id}/treinamentos');


    RegisterTreinamento registerTreinamento = RegisterTreinamento(
        cargaHorariaTotal: int.parse(cargaHorariaTotalController.text),
        nomeComercial: nomeComercialController.text,
        descricao: descricaoController.text,
        dataInicioInscricao:  DateTime.parse(dataInicioInscricaoController.text),
        dataFimInscricao: DateTime.parse(dataFimInscricaoController.text),
        dataInicioTreinamento: DateTime.parse(dataInicioTreinamentoController.text),
        dataFimTreinamento: DateTime.parse(dataFimTreinamentoController.text),
        quantidadeMinima: int.parse(quantidadeMinimaController.text),
        quantidadeMaxima: int.parse(quantidadeMaximaController.text),
        testeAptidao: selectedTesteAptidao,
        faseIntrodutorio: selectedCursosPrimeiraFase,
        primeiroCase: selectedQuizCase1,
        faseAvancada: selectedCursosSegundaFase,
        segundoCase: selectedQuizCase2);
    String jsonTreino = jsonEncode(registerTreinamento.toJson());

    try{
      http.Response response = await http.post(URL,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonTreino);

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Treinamento criado!'),
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

        case 403:
          const snackBar = SnackBar(
            content: Text('Você não tem permissão para criar um treinamento.'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        default:
          const snackBar = SnackBar(
            content: Text('Erro de Requisição'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
    }
    catch(e){
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
  void initState() {
    getCursos();
    getQuizzes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Treinamento'),
      ),

      body: ListView(
        shrinkWrap: true,
        children:[
            TextField(
              controller: cargaHorariaTotalController,
              decoration: const InputDecoration(
                labelText: 'Carga horária Total',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            TextField(
              controller: nomeComercialController,
              decoration: const InputDecoration(
                labelText: 'Nome Comercial',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
              TextField(
                controller: descricaoController,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
            TextField(
              controller: dataInicioInscricaoController,
              decoration: const InputDecoration(
                labelText: 'Data de Inicio de Inscrição',
                icon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  String dateFormatted = dateFormat.format(pickedDate);
                  setState(() {
                    dataInicioInscricaoController.text = dateFormatted;
                  });
                }
              },
            ),
            const Spacer(),
            TextField(
              controller: dataFimInscricaoController,
              decoration: const InputDecoration(
                labelText: 'Data de Final de Inscrição',
                icon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  String dateFormatted = dateFormat.format(pickedDate);
                  setState(() {
                    dataFimInscricaoController.text = dateFormatted;
                  });
                }
              },
            ),
            const Spacer(),
            TextField(
              controller: dataInicioTreinamentoController,
              decoration: const InputDecoration(
                labelText: 'Data de Início do curso',
                icon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  String dateFormatted = dateFormat.format(pickedDate);
                  setState(() {
                    dataInicioTreinamentoController.text = dateFormatted;
                  });
                }
              },
            ),
            const Spacer(),
            TextField(
              controller: dataFimTreinamentoController,
              decoration: const InputDecoration(
                labelText: 'Data de Início do curso',
                icon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  String dateFormatted = dateFormat.format(pickedDate);
                  setState(() {
                    dataFimTreinamentoController.text = dateFormatted;
                  });
                }
              },
            ),
            const Spacer(),
            TextField(
              controller: quantidadeMinimaController,
              decoration: const InputDecoration(
                labelText: 'Quantidade mínima de inscritos',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            TextField(
              controller: quantidadeMaximaController,
              decoration: const InputDecoration(
                labelText: 'Quantidade máxima inscritos',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            const Text('Selecione um Quiz de aptidão'),
            Expanded(
              child: ListView.builder(
                itemCount: quizList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Quiz quiz = quizList[index];
                  return ListTile(
                    leading: Text('${quiz.id}'),
                    title: Text(quiz.titulo),
                    subtitle: Text('Quantidade de perguntas associadas: ${quiz.perguntas.length}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: (){
                        setState(() {
                          selectedTesteAptidao = quiz;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            const Text('Selecione um Quiz para o Case Um'),
          Expanded(
              child:ListView.builder(

              itemCount: quizList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Quiz quiz = quizList[index];
                return ListTile(

                  leading: Text('${quiz.id}'),
                  title: Text(quiz.titulo),
                  subtitle: Text('Quantidade de perguntas associadas: ${quiz.perguntas.length}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: (){
                      setState(() {
                        selectedQuizCase1 = quiz;
                      });
                    },
                  ),
                );
              },
            )),
            const Spacer(),
            const Text('Selecione um Quiz para o Case Dois'),
          Expanded(
                child:ListView.builder(
              itemCount: quizList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Quiz quiz = quizList[index];
                return ListTile(
                  leading: Text('${quiz.id}'),
                  title: Text(quiz.titulo),
                  subtitle: Text('Quantidade de perguntas associadas: ${quiz.perguntas.length}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: (){
                      setState(() {
                          selectedQuizCase2 = quiz;
                      }
                      );
                    },
                  ),
                );
              },
            )),
          const Spacer(),
          const Text('Selecione cursos para a primeira fase'),
          Expanded(
              child:ListView.builder(
                itemCount: cursoList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Curso curso = cursoList[index];
                  return ListTile(
                    tileColor: selectedCursosPrimeiraFase.contains(curso) ? Colors.amber.shade900 : Colors.transparent,
                    leading: Text('${curso.id}'),
                    title: Text(curso.titulo),
                    subtitle: Text('Quantidade de perguntas associadas: ${curso.descricao}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: (){
                        setState(() {
                          if(selectedCursosPrimeiraFase.contains(curso)){
                            selectedCursosPrimeiraFase.remove(curso);
                          }
                          else {
                            selectedCursosPrimeiraFase.add(curso);
                          }
                        });
                      },
                    ),
                  );
                },
              )
          ),
          const Spacer(),
          const Text('Selecione cursos para a segunda fase'),
          Expanded(
              child:ListView.builder(
                itemCount: cursoList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Curso curso = cursoList[index];
                  return ListTile(
                    tileColor: selectedCursosSegundaFase.contains(curso) ? Colors.amber.shade900 : Colors.transparent,
                    leading: Text('${curso.id}'),
                    title: Text(curso.titulo),
                    subtitle: Text('Quantidade de perguntas associadas: ${curso.descricao}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: (){
                        setState(() {
                          if(selectedCursosSegundaFase.contains(curso)){
                            selectedCursosSegundaFase.remove(curso);
                          }
                          else {
                            selectedCursosSegundaFase.add(curso);
                          }
                        });
                      },
                    ),
                  );
                },
              )
          ),
            SizedBox(
              height: 60.0,
              child: ElevatedButton(
                onPressed: () => sendTreinamento(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Criar Treinamento',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
      ),
    );
  }
}



class IndexTreinamentoPage extends StatefulWidget {
  final User loggedUser;
  const IndexTreinamentoPage({Key? key, required this.loggedUser}) : super(key: key);
  @override
  _IndexTreinamentoPageState createState() => _IndexTreinamentoPageState();
}

class _IndexTreinamentoPageState extends State<IndexTreinamentoPage> {
  List<Treinamento>treinoList = [];

  void getTreinos() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/treinamentos'),
        headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        treinoList = jsonResponse.map((json) => Treinamento.fromJson(json)).toList();
      });
    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getTreinos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Treinamentos'),
      ),
      body: ListView.builder(
        itemCount: treinoList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Treinamento treino = treinoList[index];
          return ListTile(
            leading: Text('${treino.id}'),
            title: Text(treino.nomeComercial),
            subtitle: Text('Carga horário total: ${treino.cargaHorariaTotal}'),
          );
        },
      ),
    );
  }
}

class TreinamentoDetalhesPage extends StatelessWidget {
  final String nome;
  final String dataInicio;
  final String dataFim;
  final int minParticipantes;
  final int maxParticipantes;
  final String quizIntrodutorio;
  final String quizCase1;

  const TreinamentoDetalhesPage({
    Key? key,
    required this.nome,
    required this.dataInicio,
    required this.dataFim,
    required this.minParticipantes,
    required this.maxParticipantes,
    required this.quizIntrodutorio,
    required this.quizCase1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Treinamento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: $nome',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Data de Início: $dataInicio',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Data de Fim: $dataFim',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Mínimo de Participantes: $minParticipantes',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Máximo de Participantes: $maxParticipantes',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Quiz Introdutório: $quizIntrodutorio',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Quiz Case 1: $quizCase1',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para participar do treinamento
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Participar do Treinamento',
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

