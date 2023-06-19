import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login_page/AlunoPages/Inscricoes.dart';
import 'package:login_page/AlunoPages/SeusTreinamentos.dart';
import 'package:login_page/GeneralPage/UserDetails.dart';

import '../model/User.dart';
import 'VagaEmpregoAluno.dart';

late final User loggedUser;

List<NavigationRailDestination> alunoDestinations = [
  const NavigationRailDestination(
    icon: Icon(Icons.fitness_center_outlined),
    label: Text('Treinamentos'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.account_box_outlined),
    label: Text('Meu Perfil'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.business_center_outlined),
    label: Text('Vagas'),
  )
];

List<Widget>alunoWidgets = [
  InscricoesAlunoPage(aluno: loggedUser),
  UserDetailsPage(loggedUser: loggedUser),
  VagaEmpregoAlunoTela(loggedUser: loggedUser)
];

