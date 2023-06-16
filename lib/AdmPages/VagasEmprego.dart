import 'package:flutter/material.dart';

import '../model/User.dart';

class VagasTelaADM extends StatelessWidget{
  final User loggedUser;
  const VagasTelaADM({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                heroTag: 'createVagaEmpregoBtn',
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Criar Vaga de Emprego'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CriarVagasEmpregoPage(loggedUser: loggedUser)
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              FloatingActionButton(
                heroTag: 'indexVagaEmpregoBtn',
                child: const Icon(Icons.list_alt_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IndexVagasEmpregoPage(loggedUser: loggedUser)
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IndexVagasEmpregoPage extends StatefulWidget {
  final User loggedUser;
  const IndexVagasEmpregoPage({Key? key, required this.loggedUser}) : super(key: key);
  @override
  _IndexVagasEmpregoPageState createState() => _IndexVagasEmpregoPageState();
}

class _IndexVagasEmpregoPageState extends State<IndexVagasEmpregoPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          
        ),
      ),
    );
  }
  
}

class CriarVagasEmpregoPage extends StatefulWidget{
  const CriarVagasEmpregoPage({super.key, required User loggedUser});

  @override
  CriarVagasEmpregoPageState createState() => CriarVagasEmpregoPageState();
}

class CriarVagasEmpregoPageState extends State<CriarVagasEmpregoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            slivers: [
              
            ],
          ),
        ),
      ),
    );
  }
  
}