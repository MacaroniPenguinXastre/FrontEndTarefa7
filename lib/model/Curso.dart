import 'dart:convert';

import 'package:login_page/model/Treinamento.dart';
import 'package:login_page/model/User.dart';
import 'package:login_page/model/Values.dart';
import 'package:http/http.dart' as http;

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

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      admCriador: User.fromJson(json['admCriador']),
      materialDidatico: json['materialDidatico'],
      treinamentosCurso: List<Treinamento>.from(json['treinamentosCurso'].map((x) => Treinamento.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'admCriador': admCriador.toJson(),
      'materialDidatico': materialDidatico,
      'treinamentosCurso': List<dynamic>.from(treinamentosCurso.map((x) => x.toJson())),
    };
  }

}

class RegisterCurso{
  String titulo;
  String descricao;
  User admCriador;
  String materialDidatico;


  RegisterCurso({
    required this.titulo,
    required this.descricao,
    required this.admCriador,
    required this.materialDidatico,

  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'admCriador' : admCriador,
      'materialDidatico': materialDidatico
    };
  }

  factory RegisterCurso.fromJson(Map<String, dynamic> json) {
    return RegisterCurso(
      titulo: json['titulo'],
      descricao: json['descricao'],
      admCriador: User.fromJson(json['admCriador']),
      materialDidatico: json['materialDidatico'],
    );
  }
}