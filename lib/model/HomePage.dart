import 'package:flutter/material.dart';
import 'package:login_page/AdmPages/Cursos.dart';
import 'package:login_page/AdmPages/Perguntas.dart';
import 'package:login_page/AdmPages/Treinamentos.dart';
import 'package:login_page/AdmPages/Usuarios.dart';
import 'package:login_page/AdmPages/VagasEmprego.dart';
import 'package:login_page/AlunoPages/SeusTreinamentos.dart';
import 'package:login_page/AlunoPages/VagaEmpregoAluno.dart';
import 'package:login_page/main.dart';
import 'package:login_page/model/user.dart';

class HomePage extends StatefulWidget {
  final User loggedUser;

  const HomePage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> getWidgetsForCargo() {
    switch (widget.loggedUser.cargo) {
      case 'ADM':
        return const [CursosTelaADM(), TreinamentosTelaADM(), UsuariosTelaADM(), VagasTelaADM(), PerguntasTelaADM()];
      case 'ALUNO':
        return const [VagaEmpregoAlunoTela(), TreinamentosAlunoTela()];
      case 'EMPRESA_PARCEIRA':
        return const [];
      case 'MENTOR':
        return const [];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _page = getWidgetsForCargo();

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
                        destinations: const [],
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
