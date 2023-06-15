import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/model/User.dart';
import 'package:login_page/model/Values.dart';
import 'dart:io';
import '../main.dart';

class RegisterUserPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final url = Uri.parse('$mainURL/public/register');

  RegisterUserPage({super.key});

  void sendUser(BuildContext context) async {
    String email = emailController.text;
    String nome = nomeController.text;
    String password = passwordController.text;
    RegisterUser newUser = RegisterUser(nome, email, password, UserCargo.ALUNO.toString().split('.').last);

    String jsonUser = jsonEncode(newUser.toJson());

    try{
      http.Response response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: jsonUser);

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Cadastro Bem-Sucedido!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 400:
          const snackBar = SnackBar(
            content: Text('Usuário inválido ou já existente'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 502:
          const snackBar = SnackBar(
            content: Text('Campos nulos'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
    } catch(e){
      if(e is SocketException){
        const snackBar = SnackBar(
          content: Text('Erro de conexão: Verifique sua conexão de rede.'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final largura = MediaQuery
        .of(context)
        .size
        .width;
    final altura = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: largura,
        height: altura,
        color: Colors.black38,
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Cadastre-se'),
                const Spacer(),
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder()
                    ),
                    controller: emailController,
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder()
                    ),
                    controller: nomeController,
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder()
                    ),
                    controller: passwordController,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => sendUser(context),
                  child: const Text('CADASTRAR'),
                )],
            ),
          ),
        ),
      ),
    );
  }

}



