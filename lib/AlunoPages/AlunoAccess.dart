import 'dart:core';

import 'package:flutter/material.dart';
import 'package:login_page/AlunoPages/SeusTreinamentos.dart';
import 'package:login_page/GeneralPage/UserDetails.dart';

import 'VagaEmpregoAluno.dart';

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

List<Widget>alunoWidgets = const [
  TreinamentosAlunoTela(),
  UserDetailsPage(),
  VagaEmpregoAlunoTela()
];

