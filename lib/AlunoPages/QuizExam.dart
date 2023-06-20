import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:login_page/Service/TreinamentoService.dart';
import 'package:login_page/model/Submissao.dart';
import '../model/AlunoInscricao.dart';
import '../model/Pergunta.dart';
import '../model/Quiz.dart';
import '../model/Values.dart';

final List<String> alternativas = <String>['A','B','C','D'];
String alternativaSelected = alternativas.first;

class QuizExam extends StatefulWidget{
  final Quiz quiz;
  final AlunoInscricao alunoInscricao;
  final Submissao submissao;
  const QuizExam({super.key,required this.quiz, required this.alunoInscricao,required this.submissao});

  @override
  State<QuizExam> createState() => _QuizExamState();
}

class _QuizExamState extends State<QuizExam> {

  QuizRespostasDTO quizRespostasDTO = QuizRespostasDTO(respostas: {});

  void sendSubmissao(BuildContext context,int inscricaoID,int submissaoID)async{
    final URL = Uri.parse('$mainURL/inscricao/$inscricaoID/submissao/$submissaoID');
    String jsonSubmissao = jsonEncode(quizRespostasDTO.toJson());

    try{
      http.Response response = await http.post(URL,
          headers: {'Content-Type': 'application/json'},
        body: jsonSubmissao
      );

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Submissão realizada com sucesso!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        default:
          const snackBar = SnackBar(
            content: Text('Ocorreu um erro!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
    }
    catch(e){
      if (e is SocketException){

      }
    }
  }

  @override
  void initState(){
    List<Pergunta>perguntas = widget.quiz.perguntas;
    for(int i = 0;i < perguntas.length;i++){
      quizRespostasDTO.respostas[perguntas[i].id] = 'A';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      body: SafeArea(
          child: CustomScrollView(
              slivers: [
                sliverTextPaddingWithStyle('Teste de Aptidão: ${widget.quiz.titulo}', textTheme.titleLarge!),
                SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: widget.quiz.perguntas.length,
                          (BuildContext context,int index){
                        Pergunta pergunta = widget.quiz.perguntas[index];
                        return Card(
                          color: Theme.of(context).colorScheme.background,
                          child: Column(
                            children: [
                              Expanded(
                                flex:3,
                                child: ListTile(
                                  leading: CircleAvatar(child: Text((index+1).toString())),
                                  title: Text(pergunta.enunciado,softWrap: true,style:textTheme.titleMedium),
                                ),
                              ),
                              Text('Alternativas',softWrap: true,style: textTheme.titleLarge!),
                              Expanded(
                                flex:4,
                                child: Text('A:${pergunta.alternativaA}\nB:${pergunta.alternativaB}\n'
                                    'C:${pergunta.alternativaC}\nD:${pergunta.alternativaD}',style:textTheme.titleSmall!),
                              ),
                              Expanded(
                                flex:2,
                                child: DropdownButtonFormField<String>(
                                  value: alternativaSelected,
                                  items: alternativas.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    quizRespostasDTO.respostas.update(pergunta.id, (value) => newValue!);

                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Selecione uma alternativa',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              const Divider()
                            ],

                          ),
                        );
                      }
                  ),
                  itemExtent: 300.0,
                ),
                SliverToBoxAdapter(
                  child: FloatingActionButton.large(onPressed: (){
                    sendSubmissao(context,widget.alunoInscricao.id,widget.submissao.id);
                  }),
                )
              ]
          )
      ),
    );
  }
}