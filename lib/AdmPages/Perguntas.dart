import 'package:flutter/material.dart';

import '../model/user.dart';

class PerguntasTelaADM extends StatelessWidget{
  final User loggedUser;
  const PerguntasTelaADM({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
      ),
    );
  }
}