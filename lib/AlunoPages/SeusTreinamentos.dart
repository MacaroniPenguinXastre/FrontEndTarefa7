import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_page/model/AlunoInscricao.dart';
import 'package:login_page/model/StatusTreinamento.dart';
import 'package:login_page/model/Values.dart';
import 'package:http/http.dart' as http;

import '../model/Curso.dart';
import '../model/Treinamento.dart';
import '../model/User.dart';
import 'Inscricoes.dart';

class TreinamentosAlunoTela extends StatefulWidget{
  final User loggedUser;

  const TreinamentosAlunoTela({Key? key, required this.loggedUser}) : super(key: key);

  @override
  State<TreinamentosAlunoTela> createState() => _TreinamentosAlunoTelaState();
}

class _TreinamentosAlunoTelaState extends State<TreinamentosAlunoTela> {
  List<Treinamento>treinoList = [];

  void getTreinosAvailable() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/treinamentos/available'),
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
    getTreinosAvailable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView.separated(itemBuilder: (BuildContext context,int index){
                Treinamento treino = treinoList[index];
                return Card(
                  child: ListTile(
                      leading: Text('${treino.id}'),
                      title: Text(treino.nomeComercial),
                      subtitle: Text(treino.descricao),
                      trailing: IconButton(icon:const Icon(Icons.info_outline), onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => TreinamentoDetalhesAlunoPage(treinamento: treino,aluno: widget.loggedUser))
                        );
                      },)
                  ),
                );
              },
                  separatorBuilder: (BuildContext context,int index) => const Divider(),
                  itemCount: treinoList.length)
              ),
            ]
          ),
        ),

      ),
    );
  }
}

class TreinamentoDetalhesAlunoPage extends StatefulWidget {
  final Treinamento treinamento;
  final User aluno;

  const TreinamentoDetalhesAlunoPage({super.key,required this.treinamento,required this.aluno});


  @override
  State<TreinamentoDetalhesAlunoPage> createState() => _TreinamentoDetalhesAlunoPageState();
}

class _TreinamentoDetalhesAlunoPageState extends State<TreinamentoDetalhesAlunoPage> {
  AlunoInscricao? alunoInscricao;

  bool checkIfIsSubscribed(AlunoInscricao? alunoInscricao){
    if(alunoInscricao == null || alunoInscricao.statusTreino == StatusTreinamento.CANCELADO){
      return false;
    }
    return true;
  }

  void checkInscricaoStatus()async{
    try{
      http.Response response = await http.get(
          Uri.parse('$mainURL/aluno/${widget.aluno.id}/treinamento/${widget.treinamento.id}'),
          headers: {'Content-Type': 'application/json'}
      );
      switch(response.statusCode){
        case 200:
          Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
          AlunoInscricao inscricao = AlunoInscricao.fromJson(jsonResponse);
          setState(() {
            alunoInscricao = inscricao;
          });
          break;
        case 204:
        case 400:
          break;
      }
    }catch(e){
      if(e is SocketException){

      }
    }

  }

  @override
  void initState() {
    checkInscricaoStatus();
    super.initState();
  }

  void fazerInscricao(bool willSubscribe,BuildContext context,int alunoID,int treinamentoID)async{
    Uri url = Uri.parse('$mainURL/aluno/$alunoID/treinamentos/$treinamentoID/inscricao');
    try{
      http.Response response = await http.post(url,
          body: json.encode(willSubscribe),
          headers: {'Content-Type': 'application/json'}
      );

      print(response.statusCode);
      switch(response.statusCode){
        case 200:
          if(willSubscribe == true){
            const snackBar = SnackBar(
              content: Text('Inscrição realizada com sucesso!'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else{
            const snackBar = SnackBar(
              content: Text('Inscrição cancelada com sucesso!'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        break;
        case 409:
          const snackBar = SnackBar(
            content: Text('Não é possível se inscrever: data limite do treinamento atingido!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        default:
          const snackBar = SnackBar(
            content: Text('Erro de requisição: requisição inválida!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }

    }catch(e){
      if(e is SocketException){
        const snackBar = SnackBar(
          content: Text('Erro de conexão: Verifique sua conexão com o sistema!'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Curso>faseInicial = widget.treinamento.faseIntrodutorio;
    final List<Curso>faseAvancada = widget.treinamento.faseAvancada;
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Treinamento'),
        ),
        body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    sliverTextPaddingWithStyle(widget.treinamento.nomeComercial,textTheme.headlineMedium!),
                    sliverTextPaddingWithStyle('Descrição', textTheme.titleMedium!),
                    sliverTextPaddingWithStyle(widget.treinamento.descricao, textTheme.bodyLarge!),
                    sliverTextPaddingWithStyle('Cursos da fase Introdutória', textTheme.titleLarge!),
                    SliverFixedExtentList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: faseInicial.length,
                                (BuildContext context,int index){
                              Curso cursoFaseInicial = faseInicial[index];
                                 return Column(
                                   children: [
                                    Flexible(
                                      child: ListTile(
                                      tileColor: Theme.of(context).colorScheme.surface,
                                      leading: const Icon(Icons.book_outlined),
                                  title: Text(cursoFaseInicial.titulo,softWrap: true,style:textTheme.titleMedium),
                                  subtitle: Text('${cursoFaseInicial.descricao}',softWrap: true,style:textTheme.labelMedium),
                                  ),
                                    ),
                                      const Divider()
                                   ],
                                 );
                            }
                        ),
                        itemExtent: 75.0,
                    ),
                    sliverTextPaddingWithStyle('Cursos da fase Avançada', textTheme.titleLarge!),
                    SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: faseAvancada.length,
                              (BuildContext context,int index){
                            Curso cursoFaseAvancada = faseAvancada[index];
                            return Column(
                              children: [
                                Flexible(
                                  child: ListTile(
                                    tileColor: Theme.of(context).colorScheme.surface,
                                    leading:const Icon(Icons.book_outlined),
                                    title: Text(cursoFaseAvancada.titulo,softWrap: true,style:textTheme.titleMedium),
                                    subtitle: Text('${cursoFaseAvancada.descricao}',softWrap: true,style:textTheme.labelMedium),
                                  ),
                                ),
                                const Divider()
                              ],
                            );
                          }
                      ),
                      itemExtent: 75.0,
                    ),
                    sliverTextPaddingWithStyle('Data limite de inscrição: ${widget.treinamento.dataFimInscricao.day}/${widget.treinamento.dataFimInscricao.month}/${widget.treinamento.dataFimInscricao.year}', textTheme.titleMedium!),
                    sliverTextPaddingWithStyle('Data de início do treinamento: ${widget.treinamento.dataInicioTreinamento.day}/${widget.treinamento.dataInicioInscricao.month}/${widget.treinamento.dataInicioTreinamento.year}', textTheme.titleMedium!),
                    sliverTextPaddingWithStyle('Data final do treinamento: ${widget.treinamento.dataFimTreinamento.day}/${widget.treinamento.dataFimTreinamento.month}/${widget.treinamento.dataFimTreinamento.year}', textTheme.titleMedium!),
                    sliverPaddingFloatButton(
                      //Se já tiver inscrito, cancela a inscrição
                        checkIfIsSubscribed(alunoInscricao) ? FloatingActionButton.large(onPressed:()=> fazerInscricao(false,context,widget.aluno.id,widget.treinamento.id),
                            child: const Text('Cancelar inscrição'))
                            :
                        FloatingActionButton.large(onPressed:()=> fazerInscricao(true,context,widget.aluno.id,widget.treinamento.id),
                            child: const Text('Fazer inscrição'))
                    )
                  ],
                )

        )
    );
  }
}


