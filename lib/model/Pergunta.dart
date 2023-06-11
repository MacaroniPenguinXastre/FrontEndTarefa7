import 'package:login_page/model/User.dart';

import 'Quiz.dart';

class Pergunta{
   int id;
   String enunciado;
   String alternativaA;
   String alternativaB;
   String alternativaC;
   String alternativaD;
  //Dart não tem tipo char nativo
   String alternativaCorreta;
   User admCriador;
   List<Quiz>quizAssociados;

  Pergunta(
      this.id,
      this.enunciado,
      this.alternativaA,
      this.alternativaB,
      this.alternativaC,
      this.alternativaD,
      this.alternativaCorreta,
      this.admCriador,
      this.quizAssociados);
}