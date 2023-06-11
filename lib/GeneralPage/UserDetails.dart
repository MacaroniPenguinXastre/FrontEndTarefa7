import 'package:flutter/material.dart';

import '../model/User.dart';

class UserDetailsPage extends StatelessWidget{
  final User loggedUser;
  const UserDetailsPage({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
      ),
    );
  }
}