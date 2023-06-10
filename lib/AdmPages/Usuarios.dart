import 'package:flutter/material.dart';

import '../model/user.dart';

class UsuariosTelaADM extends StatelessWidget{
  final User loggedUser;
  const UsuariosTelaADM({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
      ),
    );
  }
}