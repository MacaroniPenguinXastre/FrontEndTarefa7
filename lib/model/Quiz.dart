import 'package:login_page/model/User.dart';
import 'Pergunta.dart';
import 'Treinamento.dart';

class Quiz {
   int id;
   String titulo;
   List<Pergunta> perguntas;
   User admCriador;
   List<Treinamento> treinamentosQuiz;

   Quiz(
       {required this.id,
          required this.titulo,
          required this.perguntas,
          required this.admCriador,
          required this.treinamentosQuiz});

   factory Quiz.fromJson(Map<String, dynamic> json) {
      return Quiz(
         id: json['id'],
         titulo: json['titulo'],
         perguntas: List<Pergunta>.from(
             json['perguntas'].map((pergunta) => Pergunta.fromJson(pergunta))),
         admCriador: User.fromJson(json['admCriador']),
         treinamentosQuiz: List<Treinamento>.from(json['treinamentosQuiz']
             .map((treinamento) => Treinamento.fromJson(treinamento))),
      );
   }

   Map<String, dynamic> toJson() {
      return {
         'id': id,
         'titulo': titulo,
         'perguntas': perguntas.map((pergunta) => pergunta.toJson()).toList(),
         'admCriador': admCriador.toJson(),
         'treinamentosQuiz':
         treinamentosQuiz.map((treinamento) => treinamento.toJson()).toList(),
      };
   }
}
class RegisterQuiz{
   String titulo;
   List<Pergunta> perguntas;
   User admCriador;

   RegisterQuiz(this.titulo, this.perguntas, this.admCriador);

   Map<String, dynamic> toJson() {
      return {
         'titulo': titulo,
         'perguntas': perguntas.map((pergunta) => pergunta.toJson()).toList(),
         'admCriador': admCriador.toJson()
      };
   }
}

