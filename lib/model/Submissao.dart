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
}
