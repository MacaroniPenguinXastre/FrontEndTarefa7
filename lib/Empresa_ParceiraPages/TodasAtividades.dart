import 'package:flutter/material.dart';

import '../model/User.dart';

class TodasAtividades extends StatefulWidget {
  final User loggedUser;
  const TodasAtividades({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _TodasAtividadesState createState() => _TodasAtividadesState();
}

class _TodasAtividadesState extends State<TodasAtividades> {
  String selectedAluno = 'Aluno1';
  String aluno1Text = 'bla bla bla aluno 1';
  String aluno2Text = 'bla bla bla aluno 2';
  String aluno3Text = 'bla bla bla aluno 3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o Aluno'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedAluno,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAluno = newValue!;
                });
              },
              items: <String>['Aluno1', 'Aluno2', 'Aluno3'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              getSelectedAlunoText(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String getSelectedAlunoText() {
    if (selectedAluno == 'Aluno1') {
      return aluno1Text;
    } else if (selectedAluno == 'Aluno2') {
      return aluno2Text;
    } else if (selectedAluno == 'Aluno3') {
      return aluno3Text;
    } else {
      return '';
    }
  }
}
