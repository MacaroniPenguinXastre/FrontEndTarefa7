import 'Treinamento.dart';
import 'User.dart';

class VagasEmprego {
  int id;
  String titulo;
  User empresa;
  String atividades;
  Treinamento treinamentoRequisito;
  double faixaSalarial;
  List<User> candidatos;

  VagasEmprego({
    required this.id,
    required this.titulo,
    required this.empresa,
    required this.atividades,
    required this.treinamentoRequisito,
    required this.faixaSalarial,
    required this.candidatos,
  });

  factory VagasEmprego.fromJson(Map<String, dynamic> json) {
    return VagasEmprego(
      id: json['id'],
      titulo: json['titulo'],
      empresa: User.fromJson(json['empresa']),
      atividades: json['atividades'],
      treinamentoRequisito: Treinamento.fromJson(json['treinamentoRequisito']),
      faixaSalarial: json['faixaSalarial'],
      candidatos: (json['candidatos'] as List<dynamic>).map((e) => User.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'empresa': empresa.toJson(),
      'atividades': atividades,
      'treinamentoRequisito': treinamentoRequisito.toJson(),
      'faixaSalarial': faixaSalarial,
      'candidatos': candidatos.map((e) => e.toJson()).toList(),
    };
  }
}

class RegisterVagasEmprego {
  String titulo;
  User empresa;
  String atividades;
  Treinamento treinamentoRequisito;
  double faixaSalarial;

  RegisterVagasEmprego({
    required this.titulo,
    required this.empresa,
    required this.atividades,
    required this.treinamentoRequisito,
    required this.faixaSalarial,

  });

  factory RegisterVagasEmprego.fromJson(Map<String, dynamic> json) {
    return RegisterVagasEmprego(
      titulo: json['titulo'],
      empresa: User.fromJson(json['empresa']),
      atividades: json['atividades'],
      treinamentoRequisito: Treinamento.fromJson(json['treinamentoRequisito']),
      faixaSalarial: json['faixaSalarial'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'empresa': empresa.toJson(),
      'atividades': atividades,
      'treinamentoRequisito': treinamentoRequisito.toJson(),
      'faixaSalarial': faixaSalarial,
    };
  }
}