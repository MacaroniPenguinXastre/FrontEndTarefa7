import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/User.dart';
import '../model/Values.dart';
import 'RegisterPage.dart';

class UsuariosTelaADM extends StatelessWidget{
  final User loggedUser;
  const UsuariosTelaADM({super.key, required this.loggedUser});

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
            /*SizedBox(
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
            ),*/
          ],
        ),
      ),
    );
  }
}

//TODO: Adapte a função abaixo para exibir todos os usuários (atualmente está para exibir cursos)
//TODO: ADM não pode apagar usuários, arranca isso tbm
/*

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
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/cursos'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        userList = jsonResponse.map((json) => User.fromJson(json)).toList();
      });

    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  void showConfirmationDialogUser(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Deseja excluir o curso "${curso.titulo}"?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deleteCurso(context, curso.id,user);
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }


  void deleteCurso(BuildContext context,int id,User user) async{
    String jsonUser = jsonEncode(user.toJson());
    http.Response response = await http.delete(
        Uri.parse('$mainURL/cursos/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonUser);

    try{
      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Curso excluído com sucesso.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            getUser();
          });
          break;

        case 403:
          const snackBar = SnackBar(
            content: Text('Curso não excluído: Usuário sem permissão.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 409:
          const snackBar = SnackBar(
            content: Text('Curso não excluído: Está associado a um ou mais treinamentos.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        default:
          const snackBar = SnackBar(
            content: Text('Erro de Requisição: Verifique se os parâmetros foram passados corretamente.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
    }catch(e){
      if(e is SocketException){
        const snackBar = SnackBar(
          content: Text('Erro de conexão: Verifique sua conexão com o sistema.'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
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
          Curso curso = userList[index];
          return ListTile(
            leading: Text('${curso.id}'),
            title: Text(curso.titulo),
            subtitle: Text(curso.descricao),
            trailing: IconButton(
              icon: const Icon(Icons.clear_outlined),
              onPressed: (){
                showConfirmationDialogUser(context,curso,widget.loggedUser);
              },
            ),
          );
        },
      ),
    );
  }
}
*/