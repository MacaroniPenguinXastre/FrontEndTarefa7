import 'package:flutter/material.dart';
import '../model/user.dart';

class TreinamentosTelaADM extends StatelessWidget {
  final User loggedUser;
  const TreinamentosTelaADM({Key? key, required this.loggedUser}) : super(key: key);

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
                  primary: Colors.transparent,
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
                      builder: (context) => DeletarTreinamentoPage(loggedUser: loggedUser),
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
  String? selectedQuizIntro;
  String? selectedQuizCase1;
  String? selectedQuizCase2;
  List<String> selectedCursosPrimeiraFase = [];
  List<String> selectedCursosSegundaFase = [];

  List<String> perguntas = ['Pergunta 1'];
  List<String> opcoes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criação de Treinamento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nome Comercial',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Carga Horária',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Data Início Inscrição',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Data Fim Inscrição',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Data Início',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Data Fim',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Mínimo de Participantes',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Máximo de Participantes',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                items: perguntas
                    .map((pergunta) => DropdownMenuItem<String>(
                  value: pergunta,
                  child: Text(pergunta),
                ))
                    .toList(),
                onChanged: (value) {},
                hint: const Text('Quiz Introdutório'),
                value: selectedQuizIntro,
                isExpanded: true,
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                items: perguntas
                    .map((pergunta) => DropdownMenuItem<String>(
                  value: pergunta,
                  child: Text(pergunta),
                ))
                    .toList(),
                onChanged: (value) {},
                hint: const Text('Quiz Case 1'),
                value: selectedQuizCase1,
                isExpanded: true,
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                items: perguntas
                    .map((pergunta) => DropdownMenuItem<String>(
                  value: pergunta,
                  child: Text(pergunta),
                ))
                    .toList(),
                onChanged: (value) {},
                hint: const Text('Quiz Case 2'),
                value: selectedQuizCase2,
                isExpanded: true,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Curso Primeira Fase',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedCursosPrimeiraFase.length,
                itemBuilder: (context, index) {
                  return DropdownButton<String>(
                    items: perguntas
                        .map((pergunta) => DropdownMenuItem<String>(
                      value: pergunta,
                      child: Text(pergunta),
                    ))
                        .toList(),
                    onChanged: (value) {},
                    hint: const Text('Selecione um curso'),
                    value: selectedCursosPrimeiraFase[index],
                    isExpanded: true,
                  );
                },
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCursosPrimeiraFase.add('');
                  });
                },
                child: const Text(
                  '+ Adicionar Curso Primeira Fase',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Curso Segunda Fase',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedCursosSegundaFase.length,
                itemBuilder: (context, index) {
                  return DropdownButton<String>(
                    items: perguntas
                        .map((pergunta) => DropdownMenuItem<String>(
                      value: pergunta,
                      child: Text(pergunta),
                    ))
                        .toList(),
                    onChanged: (value) {},
                    hint: const Text('Selecione um curso'),
                    value: selectedCursosSegundaFase[index],
                    isExpanded: true,
                  );
                },
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCursosSegundaFase.add('');
                  });
                },
                child: const Text(
                  '+ Adicionar Curso Segunda Fase',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para criar o treinamento
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
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
        ),
      ),
    );
  }
}

class CriarTreinamentosPt2 extends StatefulWidget {
  const CriarTreinamentosPt2({Key? key}) : super(key: key);

  @override
  _CriarTreinamentosPt2State createState() => _CriarTreinamentosPt2State();
}

class _CriarTreinamentosPt2State extends State<CriarTreinamentosPt2> {
  List<String> perguntas = ['Pergunta 1'];
  List<String> selectedCursosPrimeiraFase = [];
  List<String> selectedCursosSegundaFase = [];
  String? selectedQuizIntro;
  String? selectedQuizCase1;
  String? selectedQuizCase2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Treinamentos pt.2'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                items: perguntas
                    .map((pergunta) => DropdownMenuItem<String>(
                  value: pergunta,
                  child: Text(pergunta),
                ))
                    .toList(),
                onChanged: (value) {},
                hint: const Text('Quiz Introdutório'),
                value: selectedQuizIntro,
                isExpanded: true,
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                items: perguntas
                    .map((pergunta) => DropdownMenuItem<String>(
                  value: pergunta,
                  child: Text(pergunta),
                ))
                    .toList(),
                onChanged: (value) {},
                hint: const Text('Quiz Case 1'),
                value: selectedQuizCase1,
                isExpanded: true,
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                items: perguntas
                    .map((pergunta) => DropdownMenuItem<String>(
                  value: pergunta,
                  child: Text(pergunta),
                ))
                    .toList(),
                onChanged: (value) {},
                hint: const Text('Quiz Case 2'),
                value: selectedQuizCase2,
                isExpanded: true,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Curso Primeira Fase',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedCursosPrimeiraFase.length,
                itemBuilder: (context, index) {
                  return DropdownButton<String>(
                    items: perguntas
                        .map((pergunta) => DropdownMenuItem<String>(
                      value: pergunta,
                      child: Text(pergunta),
                    ))
                        .toList(),
                    onChanged: (value) {},
                    hint: const Text('Selecione um curso'),
                    value: selectedCursosPrimeiraFase[index],
                    isExpanded: true,
                  );
                },
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCursosPrimeiraFase.add('');
                  });
                },
                child: const Text(
                  '+ Adicionar Curso Primeira Fase',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Curso Segunda Fase',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedCursosSegundaFase.length,
                itemBuilder: (context, index) {
                  return DropdownButton<String>(
                    items: perguntas
                        .map((pergunta) => DropdownMenuItem<String>(
                      value: pergunta,
                      child: Text(pergunta),
                    ))
                        .toList(),
                    onChanged: (value) {},
                    hint: const Text('Selecione um curso'),
                    value: selectedCursosSegundaFase[index],
                    isExpanded: true,
                  );
                },
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCursosSegundaFase.add('');
                  });
                },
                child: const Text(
                  '+ Adicionar Curso Segunda Fase',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para criar o treinamento
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
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
        ),
      ),
    );
  }
}

class DeletarTreinamentoPage extends StatefulWidget {
  final User loggedUser;
  const DeletarTreinamentoPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _DeletarTreinamentoPageState createState() => _DeletarTreinamentoPageState();
}

class _DeletarTreinamentoPageState extends State<DeletarTreinamentoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deletar Treinamento'),
      ),
      body: Column(
        children: [
          const Text('Lista de Treinamentos'), // Adicione aqui a lista de treinamentos
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 60.0,
            child: ElevatedButton(
              onPressed: () {
                // Lógica para deletar treinamento
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
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
    );
  }
}

class TreinamentosPage extends StatefulWidget {
  final User loggedUser;
  const TreinamentosPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _TreinamentosPageState createState() => _TreinamentosPageState();
}

class _TreinamentosPageState extends State<TreinamentosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinamentos'),
      ),
      body: Column(
        children: [
          const Text('Lista de Treinamentos'), // Adicione aqui a lista de treinamentos
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 60.0,
            child: ElevatedButton(
              onPressed: () {
                // Lógica para participar de um treinamento
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'Participar de Treinamento',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
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
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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

