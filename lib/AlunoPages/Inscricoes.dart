import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/model/StatusTreinamento.dart';
import '../model/AlunoInscricao.dart';
import '../model/Curso.dart';
import '../model/User.dart';
import '../model/Values.dart';
import 'SeusTreinamentos.dart';

class InscricoesAlunoPage extends StatefulWidget {
  final User aluno;

  const InscricoesAlunoPage({super.key,required this.aluno});

  @override
  State<InscricoesAlunoPage> createState() => _InscricoesAlunoPageState();
}

class _InscricoesAlunoPageState extends State<InscricoesAlunoPage> {
  List<AlunoInscricao>inscricaoList = [];

  void getInscricoes() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/aluno/${widget.aluno.id}/inscricao/available'),
        headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        inscricaoList = jsonResponse.map((json) => AlunoInscricao.fromJson(json)).toList();

      });
    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getInscricoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton.small(onPressed: (){
                  setState(() {
                    getInscricoes();
                  });
                },
                  heroTag: 'refreshTreinamentos',
                child: const Icon(Icons.refresh_outlined),
                ),

                const Spacer(),
                FloatingActionButton.extended(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TreinamentosAlunoTela(loggedUser: widget.aluno))
                  );
                },
                  heroTag: 'listTreinamentos',
                  icon: const Icon(Icons.event_available_outlined),
                  label: const Text('Listar treinamentos'),
                ),
                const Spacer(),
                Text('Suas inscrições',softWrap: true,style: textTheme.titleLarge!),
                Expanded(
                    child: inscricaoList.isEmpty ? Text('Você não está cadastrado em nenhum treinamento',softWrap: true,style: textTheme.titleMedium!)
                        : ListView.separated(itemBuilder: (BuildContext context,int index){
                      AlunoInscricao inscricao = inscricaoList[index];
                      return Card(
                        child: ListTile(
                            leading: Text('${inscricao.id}'),
                            title: Text(inscricao.treinamento.nomeComercial),
                            subtitle: Text('Status: ${inscricao.statusTreino.toString().split('.').last}'),
                            trailing: inscricao.statusTreino == StatusTreinamento.INSCRITO ? IconButton(icon:const Icon(Icons.info_outline), onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => AlunoInscricaoDetalhesAlunoPage(alunoInscricao: inscricao,aluno: widget.aluno))
                              );
                            },
                            )
                                :
                            IconButton(icon:const Icon(Icons.add_circle_outline), onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => TreinamentoDetalhesAlunoPage(treinamento: inscricao.treinamento,aluno: widget.aluno))
                              );
                            },
                            )
                        ),
                      );
                    },
                        separatorBuilder: (BuildContext context,int index) => const Divider(),
                        itemCount: inscricaoList.length)
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class AlunoInscricaoDetalhesAlunoPage extends StatefulWidget {
  final AlunoInscricao alunoInscricao;
  final User aluno;

  const AlunoInscricaoDetalhesAlunoPage({super.key,required this.alunoInscricao,required this.aluno});

  @override
  State<AlunoInscricaoDetalhesAlunoPage> createState() => _AlunoInscricaoDetalhesAlunoPageState();
}

class _AlunoInscricaoDetalhesAlunoPageState extends State<AlunoInscricaoDetalhesAlunoPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Inscrição'),
        ),
        body: SafeArea(
            child: CustomScrollView(
              slivers: [
                sliverTextPaddingWithStyle('${widget.alunoInscricao.treinamento.nomeComercial}',textTheme.headlineMedium!),
                sliverTextPaddingWithStyle('Cursos', textTheme.titleLarge!),
                sliverTextPaddingWithStyle('Fase introdutória', textTheme.titleMedium!),
                SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: widget.alunoInscricao.treinamento.faseIntrodutorio.length,
                          (BuildContext context,int index){
                        Curso cursoFaseIntrodutoria = widget.alunoInscricao.treinamento.faseIntrodutorio[index];
                        return Column(
                          children: [
                            Flexible(
                              child: Card(
                                child: ListTile(
                                  leading:const Icon(Icons.book_outlined),
                                  title: Text(cursoFaseIntrodutoria.titulo,softWrap: true,style:textTheme.titleMedium),
                                  subtitle: Text('${cursoFaseIntrodutoria.descricao}',softWrap: true,style:textTheme.labelMedium),
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      }
                  ),
                  itemExtent: 100.0,
                ),
                sliverTextPaddingWithStyle('Fase avançada', textTheme.titleMedium!),
                SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: widget.alunoInscricao.treinamento.faseAvancada.length,
                          (BuildContext context,int index){
                        Curso cursoFaseAvancada = widget.alunoInscricao.treinamento.faseAvancada[index];
                        return Column(
                          children: [
                            Flexible(
                              child: Card(
                                child: ListTile(
                                  leading:const Icon(Icons.book_outlined),
                                  title: Text(cursoFaseAvancada.titulo,softWrap: true,style:textTheme.titleMedium),
                                  subtitle: Text('${cursoFaseAvancada.descricao}',softWrap: true,style:textTheme.labelMedium),

                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      }
                  ),
                  itemExtent: 100.0,
                ),

                ]
            )

        )
    );
  }
}
