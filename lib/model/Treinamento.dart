import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'Curso.dart';
import 'Quiz.dart';
import 'User.dart';
import 'Values.dart';

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
    final dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");

    return {
      'id': id,
      'cargaHorariaTotal': cargaHorariaTotal,
      'nomeComercial': nomeComercial,
      'descricao': descricao,
      'dataInicioInscricao': dateFormat.format(dataInicioInscricao),
      'dataFimInscricao': dateFormat.format(dataFimInscricao),
      'dataInicioTreinamento': dateFormat.format(dataInicioTreinamento),
      'dataFimTreinamento': dateFormat.format(dataFimTreinamento),
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



class RegisterTreinamento {
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

  RegisterTreinamento({
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

  factory RegisterTreinamento.fromJson(Map<String, dynamic> json) {
    return RegisterTreinamento(
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
    final dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    return {
      'cargaHorariaTotal': cargaHorariaTotal,
      'nomeComercial': nomeComercial,
      'descricao': descricao,
      'dataInicioInscricao': dateFormat.format(dataInicioInscricao),
      'dataFimInscricao': dateFormat.format(dataFimInscricao),
      'dataInicioTreinamento': dateFormat.format(dataInicioTreinamento),
      'dataFimTreinamento': dateFormat.format(dataFimTreinamento),
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

