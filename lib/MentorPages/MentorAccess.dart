import 'dart:core';

import 'package:flutter/material.dart';
import 'package:login_page/AlunoPages/AlunoAccess.dart';
import 'package:login_page/GeneralPage/UserDetails.dart';
import 'ultimas10atividades.dart';


List<NavigationRailDestination> mentorDestinations = [
  const NavigationRailDestination(
    icon: Icon(Icons.access_time),
    label: Text('Ultimas 10 Atividades'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.account_box_outlined),
    label: Text('Meu Perfil'),
  )
];

List<Widget>mentorWidgets =[
  Ultimas10Atividades(loggedUser: loggedUser),
  UserDetailsPage(loggedUser: loggedUser)
];

