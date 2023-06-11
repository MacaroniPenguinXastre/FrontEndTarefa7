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
  Map<Pergunta, String> respostas;

  Submissao({
    required this.id,
    required this.aluno,
    required this.treinamentos,
    required this.quiz,
    required this.nota,
    required this.respostas,
  });

  factory Submissao.fromJson(Map<String, dynamic> json) {
    return Submissao(
      id: json['id'],
      aluno: User.fromJson(json['aluno']),
      treinamentos: Treinamento.fromJson(json['treinamentos']),
      quiz: Quiz.fromJson(json['quiz']),
      nota: json['nota'],
      respostas: Map<Pergunta, String>.from(json['respostas'].map(
            (key, value) => MapEntry(Pergunta.fromJson(key), value),
      )),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aluno': aluno.toJson(),
      'treinamentos': treinamentos.toJson(),
      'quiz': quiz.toJson(),
      'nota': nota,
      'respostas': Map<String, String>.from(respostas.map(
            (key, value) => MapEntry(key.toJson(), value),
      )),
    };
  }
}
