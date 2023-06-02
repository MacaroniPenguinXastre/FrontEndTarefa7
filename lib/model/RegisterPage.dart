import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/model/user.dart';
import 'dart:io';
import '../main.dart';

class RegisterPage extends StatelessWidget {
  UserCargo? selectedCargo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final url = Uri.parse('http://localhost:8888/public/register');

  RegisterPage({Key? key});

  List<DropdownMenuItem<UserCargo>> _buildCargoDropdownMenuItems() {
    return UserCargo.values.map((UserCargo cargo) {
      return DropdownMenuItem<UserCargo>(
        value: cargo,
        child: Text(cargo.toString()),
      );
    }).toList();
  }

  void sendUser(BuildContext context) async {
    String email = emailController.text;
    String nome = nomeController.text;
    String password = passwordController.text;
    String cargo = UserCargo.ALUNO.toString();
    RegisterUser newUser = RegisterUser(nome, email, password, cargo);

    String jsonUser = jsonEncode(newUser.toJson());

    try{
      http.Response response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: jsonUser);

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(content: Text('Cadastro Bem-Sucedido!'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 400:
          const snackBar = SnackBar(content: Text('Usuário inválido ou já existente'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
    } catch(e){
      if(e is SocketException){
        const snackBar = SnackBar(content: Text('Erro de conexão: Verifique sua conexão de rede.'));
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
    final errorMessage error = errorMessage();
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


