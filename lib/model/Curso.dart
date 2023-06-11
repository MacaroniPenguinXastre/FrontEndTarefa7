import 'package:login_page/model/Treinamento.dart';
import 'package:login_page/model/User.dart';

class Curso {
  int id;
  String titulo;
  String descricao;
  User admCriador;
  String materialDidatico;
  List<Treinamento> treinamentosCurso;

  Curso({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.admCriador,
    required this.materialDidatico,
    required this.treinamentosCurso
  });

}