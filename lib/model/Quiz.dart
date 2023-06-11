import 'package:login_page/model/User.dart';
import 'Pergunta.dart';
import 'Treinamento.dart';

class Quiz{
   int id;
   String titulo;
   List<Pergunta>perguntas;
   User admCriador;
   List<Treinamento>treinamentosQuiz;

  Quiz(this.id, this.titulo, this.perguntas, this.admCriador,
      this.treinamentosQuiz);
}
