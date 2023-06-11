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

  factory Treinamento.fromJson(Map<String, dynamic> json) {
    return Treinamento(
      id: json['id'],
      cargaHorariaTotal: json['cargaHorariaTotal'],
      nomeComercial: json['nomeComercial'],
      descricao: json['descricao'],
      dataInicioInscricao: DateTime.parse(json['dataInicioInscricao']),
      dataFimInscricao: DateTime.parse(json['dataFimInscricao']),
      dataInicioTreinamento: DateTime.parse(json['dataInicioTreinamento']),
      dataFimTreinamento: DateTime.parse(json['dataFimTreinamento']),
      quantidadeMinima: json['quantidadeMinima'],
      quantidadeMaxima: json['quantidadeMaxima'],
      testeAptidao: Quiz.fromJson(json['testeAptidao']),
      faseIntrodutorio: List<Curso>.from(json['faseIntrodutorio'].map((x) => Curso.fromJson(x))),
      primeiroCase: Quiz.fromJson(json['primeiroCase']),
      faseAvancada: List<Curso>.from(json['faseAvancada'].map((x) => Curso.fromJson(x))),
      segundoCase: Quiz.fromJson(json['segundoCase']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cargaHorariaTotal': cargaHorariaTotal,
      'nomeComercial': nomeComercial,
      'descricao': descricao,
      'dataInicioInscricao': dataInicioInscricao.toIso8601String(),
      'dataFimInscricao': dataFimInscricao.toIso8601String(),
      'dataInicioTreinamento': dataInicioTreinamento.toIso8601String(),
      'dataFimTreinamento': dataFimTreinamento.toIso8601String(),
      'quantidadeMinima': quantidadeMinima,
      'quantidadeMaxima': quantidadeMaxima,
      'testeAptidao': testeAptidao.toJson(),
      'faseIntrodutorio': List<dynamic>.from(faseIntrodutorio.map((x) => x.toJson())),
      'primeiroCase': primeiroCase.toJson(),
      'faseAvancada': List<dynamic>.from(faseAvancada.map((x) => x.toJson())),
      'segundoCase': segundoCase.toJson(),
    };
  }
}
