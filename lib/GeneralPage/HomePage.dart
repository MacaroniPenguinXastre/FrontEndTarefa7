import 'package:flutter/material.dart';
import 'package:login_page/AdmPages/AdmAccess.dart';
import 'package:login_page/Empresa_ParceiraPages/Empresa_ParceiraAccess.dart';
import 'package:login_page/MentorPages/MentorAccess.dart';
import 'package:login_page/AdmPages/Cursos.dart';
import 'package:login_page/AdmPages/Perguntas.dart';
import 'package:login_page/AdmPages/QuizPage.dart';
import 'package:login_page/AdmPages/Treinamentos.dart';
import 'package:login_page/AdmPages/Usuarios.dart';
import 'package:login_page/AdmPages/VagasEmpregoAdm.dart';
import 'package:login_page/AlunoPages/SeusTreinamentos.dart';
import 'package:login_page/AlunoPages/VagaEmpregoAluno.dart';
import 'package:login_page/model/User.dart';
import 'dart:core';

import '../AlunoPages/AlunoAccess.dart';
import '../Empresa_ParceiraPages/TodasAtividades.dart';
import 'UserDetails.dart';
import '../MentorPages/ultimas10atividades.dart';

class WidgetAndDestination {
  final List<Widget> widgets;
  final List<NavigationRailDestination> destinations;

  WidgetAndDestination(this.widgets, this.destinations);
}

class HomePage extends StatefulWidget {

  final User loggedUser;

  const HomePage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  WidgetAndDestination getWidgetsForCargo() {
    switch (widget.loggedUser.cargo) {
      case 'ADM':
        List<Widget> admWidgets = [
          CursosTelaADM(loggedUser: widget.loggedUser),
          TreinamentosTelaADM(loggedUser: widget.loggedUser),
          UsuariosTelaADM(loggedUser: widget.loggedUser),
          VagasTelaADM(loggedUser: widget.loggedUser),
          PerguntaScreenADM(loggedUser: widget.loggedUser),
          QuizTelaADM(loggedUser: widget.loggedUser),
        ];
        return WidgetAndDestination(
          admWidgets,
          destinationsAdm,
        );
      case 'ALUNO':
        List<Widget>alunoWidgets = [
          TreinamentosAlunoTela(loggedUser: widget.loggedUser),
          UserDetailsPage(loggedUser: widget.loggedUser),
          VagaEmpregoAlunoTela(loggedUser: widget.loggedUser)
        ];
        return WidgetAndDestination(
            alunoWidgets,
            alunoDestinations
        );
        case 'EMPRESA_PARCEIRA':
          List<Widget>empresaWidgets = [
            UserDetailsPage(loggedUser: widget.loggedUser),
            TodasAtividades(loggedUser: widget.loggedUser)
          ];
        return WidgetAndDestination(
            empresaWidgets,
            empresaDestinations
        );
      case 'MENTOR':
        List<Widget>mentorWidgets =[
          Ultimas10Atividades(loggedUser: widget.loggedUser),
          UserDetailsPage(loggedUser: widget.loggedUser)
        ];
        return WidgetAndDestination(
            mentorWidgets,
            mentorDestinations
        );
      default:
        return WidgetAndDestination(
            [],
            []
        );
    }
  }




  @override
  Widget build(BuildContext context) {
    final WidgetAndDestination widgetsAndDestination = getWidgetsForCargo();
    final List<Widget> _page = widgetsAndDestination.widgets;
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              elevation: 4,
              groupAlignment: 0.0,
              selectedIndex: selectedIndex,
              useIndicator: true,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: widgetsAndDestination.destinations,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(

              flex: 4,
              child: IndexedStack(
                index: selectedIndex,
                children: _page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
