import 'Curso.dart';
import 'Quiz.dart';

class Treinamento {
  int id;
  int cargaHorariaTotal;
  String nomeComercial;
  String descricao;
  DateTime dataInicioInscricao;
  DateTime dataFimInscricao;
  DateTime dataInicioTreinamento;
  DateTime dataFimTreinamento;
  int quantidadeMinima;
  int quantidadeMaxima;
  Quiz testeAptidao;
  List<Curso> faseIntrodutorio;
  Quiz primeiroCase;
  List<Curso> faseAvancada;
  Quiz segundoCase;

  Treinamento({
    required this.id,
    required this.cargaHorariaTotal,
    required this.nomeComercial,
    required this.descricao,
    required this.dataInicioInscricao,
    required this.dataFimInscricao,
    required this.dataInicioTreinamento,
    required this.dataFimTreinamento,
    required this.quantidadeMinima,
    required this.quantidadeMaxima,
    required this.testeAptidao,
    required this.faseIntrodutorio,
    required this.primeiroCase,
    required this.faseAvancada,
    required this.segundoCase,
  });
}
