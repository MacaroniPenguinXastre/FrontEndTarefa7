import 'package:login_page/model/User.dart';

import 'Quiz.dart';

class Pergunta {
   int id;
   String enunciado;
   String alternativaA;
   String alternativaB;
   String alternativaC;
   String alternativaD;
   String alternativaCorreta;
   User admCriador;
   List<Quiz> quizAssociados;

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

   factory Pergunta.fromJson(Map<String, dynamic> json) {
      return Pergunta(
         json['id'],
         json['enunciado'],
         json['alternativaA'],
         json['alternativaB'],
         json['alternativaC'],
         json['alternativaD'],
         json['alternativaCorreta'],
         User.fromJson(json['admCriador']),
         List<Quiz>.from(
             json['quizAssociados'].map((quiz) => Quiz.fromJson(quiz))),
      );
   }

   Map<String, dynamic> toJson() {
      return {
         'id': id,
         'enunciado': enunciado,
         'alternativaA': alternativaA,
         'alternativaB': alternativaB,
         'alternativaC': alternativaC,
         'alternativaD': alternativaD,
         'alternativaCorreta': alternativaCorreta,
         'admCriador': admCriador.toJson(),
         'quizAssociados': quizAssociados.map((quiz) => quiz.toJson()).toList(),
      };
   }
}


class RegisterPergunta{
   String enunciado;
   String alternativaA;
   String alternativaB;
   String alternativaC;
   String alternativaD;
   String alternativaCorreta;
   User admCriador;

   RegisterPergunta(
       this.enunciado,
       this.alternativaA,
       this.alternativaB,
       this.alternativaC,
       this.alternativaD,
       this.alternativaCorreta,
       this.admCriador);

   factory RegisterPergunta.fromJson(Map<String, dynamic> json) {
      return RegisterPergunta(
         json['enunciado'],
         json['alternativaA'],
         json['alternativaB'],
         json['alternativaC'],
         json['alternativaD'],
         json['alternativaCorreta'],
         User.fromJson(json['admCriador']),
      );
   }

   Map<String, dynamic> toJson() {
      return {
         'enunciado': enunciado,
         'alternativaA': alternativaA,
         'alternativaB': alternativaB,
         'alternativaC': alternativaC,
         'alternativaD': alternativaD,
         'alternativaCorreta': alternativaCorreta,
         'admCriador': admCriador.toJson()
      };
   }
}