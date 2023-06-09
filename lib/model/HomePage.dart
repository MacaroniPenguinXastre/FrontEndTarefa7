import 'package:flutter/material.dart';
import 'package:login_page/AdmPages/AdmAccess.dart';
import 'package:login_page/model/user.dart';
import 'dart:core';

import '../AlunoPages/AlunoAccess.dart';

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
        return WidgetAndDestination(
            admWidgets,
            destinationsAdm
        );

      case 'ALUNO':
        return WidgetAndDestination(
            alunoWidgets,
            alunoDestinations
        );
        case 'EMPRESA_PARCEIRA':
        return WidgetAndDestination(
            [],
            []
        );
      case 'MENTOR':
        return WidgetAndDestination(
            [],
            []
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
      appBar: AppBar(
        title: Text('Olá, ${widget.loggedUser.nome}'),
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.white70,
                child: Column(
                  children: [
                    Expanded(
                      child: NavigationRail(
                        extended: true,
                        selectedIndex: selectedIndex,
                        onDestinationSelected: (int index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        destinations: widgetsAndDestination.destinations,
                      ),
                    )
                  ],
                ),
              ),
            ),
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
