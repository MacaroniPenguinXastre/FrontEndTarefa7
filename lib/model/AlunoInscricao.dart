import 'StatusTreinamento.dart';
import 'Submissao.dart';
import 'Treinamento.dart';
import 'User.dart';

class AlunoInscricao {
  int id;
  User aluno;
  Treinamento treinamento;
  Submissao quizIntroducao;
  Submissao caseOne;
  Submissao caseTwo;
  StatusTreinamento statusTreino;
  DateTime dataInscricao;

  AlunoInscricao({
    required this.id,
    required this.aluno,
    required this.treinamento,
    required this.quizIntroducao,
    required this.caseOne,
    required this.caseTwo,
    required this.statusTreino,
    required this.dataInscricao,
  });

  factory AlunoInscricao.fromJson(Map<String, dynamic> json) {
    return AlunoInscricao(
      id: json['id'],
      aluno: User.fromJson(json['aluno']),
      treinamento: Treinamento.fromJson(json['treinamento']),
      quizIntroducao: Submissao.fromJson(json['quizIntroducao']),
      caseOne: Submissao.fromJson(json['caseOne']),
      caseTwo: Submissao.fromJson(json['caseTwo']),
      statusTreino: statusTreinamentoFromJson(json['statusTreino']),
      dataInscricao: DateTime.parse(json['dataInscricao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aluno': aluno.toJson(),
      'treinamento': treinamento.toJson(),
      'quizIntroducao': quizIntroducao.toJson(),
      'caseOne': caseOne.toJson(),
      'caseTwo': caseTwo.toJson(),
      'statusTreino': statusTreinamentoToJson(statusTreino),
      'dataInscricao': dataInscricao.toIso8601String(),
    };
  }
}
