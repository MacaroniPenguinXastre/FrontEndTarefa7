import 'dart:core';

import 'package:flutter/material.dart';
import 'package:login_page/AlunoPages/AlunoAccess.dart';
import 'package:login_page/Empresa_ParceiraPages/TodasAtividades.dart';
import 'package:login_page/GeneralPage/UserDetails.dart';


List<NavigationRailDestination> empresaDestinations = [
  const NavigationRailDestination(
    icon: Icon(Icons.account_box_outlined),
    label: Text('Meu Perfil'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.business_center_outlined),
    label: Text('Todas as Atividades'),
  )
];

List<Widget>empresaWidgets = [
  UserDetailsPage(loggedUser: loggedUser),
  TodasAtividades(loggedUser: loggedUser)
];

