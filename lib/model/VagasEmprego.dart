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
}