import 'dart:core';

import 'package:flutter/material.dart';
import 'Cursos.dart';
import 'Perguntas.dart';
import 'Quiz.dart';
import 'Treinamentos.dart';
import 'Usuarios.dart';
import 'VagasEmprego.dart';

List<NavigationRailDestination> destinationsAdm = [
  const NavigationRailDestination(
    icon: Icon(Icons.class_outlined),
    label: Text('Cursos'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.fitness_center_outlined),
    label: Text('Treinamentos'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.account_box_outlined),
    label: Text('Usuários'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.business_center_outlined),
    label: Text('Vagas'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.question_mark_outlined),
    label: Text('Perguntas'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.quiz_outlined),
    label: Text('Quiz'),
  )
];

List<Widget>admWidgets = const [
  CursosTelaADM(),
  TreinamentosTelaADM(),
  UsuariosTelaADM(),
  VagasTelaADM(),
  PerguntasTelaADM(),
  QuizTelaADM()
];

