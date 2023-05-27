import 'package:flutter/material.dart';
import 'package:login_page/main.dart';
import 'package:login_page/model/user.dart';

class HomePage extends StatefulWidget{
  final User loggedUser;

  const HomePage({Key? key, required this.loggedUser}) : super(key: key);
  @override
  HomePageState createState() => HomePageState(loggedUser: loggedUser);

}


class HomePageState extends State<HomePage>{
  final User loggedUser;

  HomePageState({required this.loggedUser});

  int selectedIndex = 0;
  final List<Widget> _page = [const TestScreen(),const PracticeScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${loggedUser.nome}')
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
                        onDestinationSelected: (int index){
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        destinations: const [
                          NavigationRailDestination(icon: Icon(Icons.home_rounded),
                              label: Text('Home')),
                          NavigationRailDestination(icon: Icon(Icons.school_rounded),
                              label: Text('Cursos'))
                        ],
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
              )
            )
          ],
        ),
      ),
    );
  }
  
}

class TestScreen extends StatelessWidget{
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
      ),
    );
  }
}

class PracticeScreen extends StatelessWidget{
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple,
      ),
    );
  }
}