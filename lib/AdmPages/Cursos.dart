import 'package:flutter/material.dart';
import 'package:login_page/model/user.dart';

class CursosTelaADM extends StatelessWidget{
  final User loggedUser;
  const CursosTelaADM({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
      ),
    );
  }
}