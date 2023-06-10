import 'package:flutter/material.dart';

import '../model/user.dart';

class TreinamentosTelaADM extends StatelessWidget{
  final User loggedUser;
  const TreinamentosTelaADM({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple,
      ),
    );
  }
}