import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../GeneralPage/UserDetails.dart';
import '../model/User.dart';
import '../model/Values.dart';
import 'RegisterPage.dart';


class UsuariosTelaADM extends StatelessWidget {
  final User loggedUser;
  const UsuariosTelaADM({Key? key, required this.loggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(loggedUser: loggedUser),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Criar Usuário',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 200.0,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndexUserPage(loggedUser: loggedUser),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Exibir todos os usuários',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IndexUserPage extends StatefulWidget {
  final User loggedUser;
  const IndexUserPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _IndexUserPageState createState() => _IndexUserPageState();
}

class _IndexUserPageState extends State<IndexUserPage> {
  List<User> userList = [];
  bool isConfirmedShowed = false;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL/adm/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        userList = jsonResponse.map((json) => User.fromJson(json)).toList();
      });
    } else {
      print('Erro: ${response.statusCode}');
    }
  }

  void showUserDetails(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsPage(loggedUser: user), // Passa o usuário selecionado
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Cursos'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          User user = userList[index];
          return ListTile(
            leading: Text('${user.id}'),
            title: Text(user.nome),
            subtitle: Text(user.cargo),
            trailing: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                showUserDetails(user); // Chama o método showUserDetails ao invés de Navigator.push
              },
            ),
          );
        },
      ),
    );
  }

}
