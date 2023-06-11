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
}