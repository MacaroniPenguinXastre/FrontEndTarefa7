import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/User.dart';
import '../model/Values.dart';

class UserDetailsPage extends StatefulWidget {
  final User loggedUser;
  const UserDetailsPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late Future<User> userDetails;

  @override
  void initState() {
    super.initState();
    userDetails = getUserDetails();
  }

  Future<User> getUserDetails() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL/adm/users/${widget.loggedUser.id}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return User.fromJson(jsonResponse);
    } else {
      print('Erro: ${response.statusCode}');
      throw Exception('Failed to load user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Usuário'),
      ),
      body: FutureBuilder<User>(
        future: userDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data!;
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${user.id}'),
                  Text('Nome: ${user.nome}'),
                  Text('Cargo: ${user.cargo}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os detalhes do usuário'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
