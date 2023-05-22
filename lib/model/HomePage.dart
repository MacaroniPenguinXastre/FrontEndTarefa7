import 'package:flutter/material.dart';
import 'package:login_page/main.dart';

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();

}


class HomePageState extends State<HomePage>{
  int selectedIndex = 0;
  List<Widget> _page = [TestScreen(),OtherScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        destinations: [
                          NavigationRailDestination(icon: Icon(Icons.add_circle_outline),
                              label: Text('')),
                          NavigationRailDestination(icon: Icon(Icons.ac_unit),
                              label: Text(''))
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
      ),
    );
  }
}

class OtherScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple,
      ),
    );
  }
}