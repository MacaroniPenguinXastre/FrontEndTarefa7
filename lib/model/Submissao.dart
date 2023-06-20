import 'Pergunta.dart';
import 'Quiz.dart';
import 'Treinamento.dart';
import 'User.dart';

class Submissao {
  int id;
  User aluno;
  Treinamento treinamentos;
  Quiz quiz;
  int nota;
  Map<int, String> respostas;

  Submissao({
    required this.id,
    required this.aluno,
    required this.treinamentos,
    required this.quiz,
    required this.nota,
    required this.respostas,
  });

  factory Submissao.fromJson(Map<String, dynamic> json) {
    final aluno = User.fromJson(json['aluno']);
    final treinamentos = Treinamento.fromJson(json['treinamentos']);
    final quiz = Quiz.fromJson(json['quiz']);
    final nota = json['nota'];

    final respostasJson = json['respostas'];
    final respostas = respostasJson.map<int, String>((key, value) {
      return MapEntry(int.parse(key), value.toString());
    });

    return Submissao(
      id: json['id'],
      aluno: aluno,
      treinamentos: treinamentos,
      quiz: quiz,
      nota: nota,
      respostas: respostas,
    );
  }

  Map<String, dynamic> toJson() {
    final alunoJson = aluno.toJson();
    final treinamentosJson = treinamentos.toJson();
    final quizJson = quiz.toJson();
    final notaJson = nota;

    final respostasJson = respostas.map<String, String>((key, value) {
      return MapEntry(key.toString(), value);
    });

    return {
      'id': id,
      'aluno': alunoJson,
      'treinamentos': treinamentosJson,
      'quiz': quizJson,
      'nota': notaJson,
      'respostas': respostasJson,
    };
  }
}