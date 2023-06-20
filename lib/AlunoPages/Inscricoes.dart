import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/AlunoPages/QuizExam.dart';
import 'package:login_page/model/StatusTreinamento.dart';
import '../model/AlunoInscricao.dart';
import '../model/Curso.dart';
import '../model/User.dart';
import '../model/Values.dart';
import 'SeusTreinamentos.dart';

class InscricoesAlunoPage extends StatefulWidget {
  final User aluno;

  const InscricoesAlunoPage({Key? key, required this.aluno}) : super(key: key);

  @override
  State<InscricoesAlunoPage> createState() => _InscricoesAlunoPageState();
}

class _InscricoesAlunoPageState extends State<InscricoesAlunoPage> {
  List<AlunoInscricao> inscricaoList = [];

  void getInscricoes() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/aluno/${widget.aluno.id}/inscricao/available'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        inscricaoList = jsonResponse
            .map((json) => AlunoInscricao.fromJson(json))
            .toList();
      });

    }
    else {
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
              Row(
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      setState(() {
                        getInscricoes();
                      });
                    },
                    heroTag: 'refreshTreinamentos',
                    child: const Icon(Icons.refresh_outlined),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TreinamentosAlunoTela(loggedUser: widget.aluno),
                        ),
                      );
                    },
                    heroTag: 'listTreinamentos',
                    icon: const Icon(Icons.event_available_outlined),
                    label: const Text('Listar treinamentos'),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Suas inscrições',
                softWrap: true,
                style: textTheme.headline4!,
              ),
              Expanded(
                child: inscricaoList.isEmpty
                    ? Text(
                  'Você não está cadastrado em nenhum treinamento',
                  softWrap: true,
                  style: textTheme.headline6!,
                )
                    : ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    AlunoInscricao inscricao = inscricaoList[index];
                    return Card(
                      child: ListTile(
                        leading: Text('${inscricao.id}'),
                        title: Text(inscricao.treinamento.nomeComercial),
                        subtitle: Text(
                          'Status: ${inscricao.statusTreino.toString().split('.').last}',
                        ),
                        trailing: inscricao.statusTreino == StatusTreinamento.INSCRITO
                            ? IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AlunoInscricaoDetalhesAlunoPage(
                                      alunoInscricao: inscricao,
                                      aluno: widget.aluno,
                                    ),
                              ),
                            );
                          },
                        )
                            : IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TreinamentoDetalhesAlunoPage(
                                      treinamento: inscricao.treinamento,
                                      aluno: widget.aluno,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemCount: inscricaoList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlunoInscricaoDetalhesAlunoPage extends StatelessWidget {
  final AlunoInscricao alunoInscricao;
  final User aluno;

  const AlunoInscricaoDetalhesAlunoPage({
    Key? key,
    required this.alunoInscricao,
    required this.aluno,
  }) : super(key: key);

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
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alunoInscricao.treinamento.nomeComercial,
                      style: textTheme.headline6,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Descrição do Treinamento:',
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      alunoInscricao.treinamento.descricao,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizExam(quiz: alunoInscricao.quizIntroducao.quiz, alunoInscricao: alunoInscricao, submissao: alunoInscricao.quizIntroducao),
                          ),
                        );
                      },
                      child: const Text('Realizar Teste de Aptidão'),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      'Cursos',
                      style: textTheme.headline6,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Fase introdutória',
                      style: textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Curso cursoFaseIntrodutoria =
                  alunoInscricao.treinamento.faseIntrodutorio[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.book_outlined),
                        title: Text(
                          cursoFaseIntrodutoria.titulo,
                          softWrap: true,
                          style: textTheme.subtitle1,
                        ),
                        subtitle: Text(
                          cursoFaseIntrodutoria.descricao,
                          softWrap: true,
                          style: textTheme.bodyText1,
                        ),
                      ),
                    ),
                  );
                },
                childCount: alunoInscricao.treinamento.faseIntrodutorio.length,
              ),
              itemExtent: 100.0,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Fase avançada',
                  style: textTheme.subtitle1,
                ),
              ),
            ),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Curso cursoFaseAvancada =
                  alunoInscricao.treinamento.faseAvancada[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.book_outlined),
                        title: Text(
                          cursoFaseAvancada.titulo,
                          softWrap: true,
                          style: textTheme.subtitle1,
                        ),
                        subtitle: Text(
                          cursoFaseAvancada.descricao,
                          softWrap: true,
                          style: textTheme.bodyText1,
                        ),
                      ),
                    ),
                  );
                },
                childCount: alunoInscricao.treinamento.faseAvancada.length,
              ),
              itemExtent: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}

class RealizarTestePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realizar Teste de Aptidão'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Realizar Teste de Aptidão',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Iniciar Teste'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
