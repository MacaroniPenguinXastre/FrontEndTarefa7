import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class registerPage extends StatelessWidget {
  UserCargo? selectedCargo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final url = Uri.parse('http://localhost:8888/public/register');

  registerPage({super.key});

  List<DropdownMenuItem<UserCargo>> _buildCargoDropdownMenuItems() {
    return UserCargo.values.map((UserCargo cargo) {
      return DropdownMenuItem<UserCargo>(
        value: cargo,
        child: Text(cargo.toString()),
      );
    }).toList();
  }

  void sendUser() async {
    String email = emailController.text;
    String nome = nomeController.text;
    String password = passwordController.text;
    String cargo = selectedCargo.toString().split('.').last;
    RegisterUser newUser = RegisterUser(nome, email, password, cargo);

    String jsonUser = jsonEncode(newUser.toJson());

    http.Response response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonUser);

    if (response.statusCode == 200) {
      print('Cadastro feito com sucesso');
      Fluttertoast.showToast(
        msg: 'Cadastro feito com sucesso',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<UserCargo> cargoOptions = UserCargo.values.toList();

    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
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
                          labelText: 'Email', border: OutlineInputBorder()),
                      controller: emailController,
                    )),
                const Spacer(),
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Nome', border: OutlineInputBorder()),
                    controller: nomeController,
                  ),
                ),
                const Spacer(),
                Flexible(
                    flex: 3,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Senha', border: OutlineInputBorder()),
                      controller: passwordController,
                    )),
                const Spacer(),
                Flexible(
                    flex: 3,
                    child: DropdownButtonFormField<UserCargo>(
                      value: selectedCargo,
                      items: cargoOptions.map((cargo) {
                        return DropdownMenuItem<UserCargo>(
                          value: cargo,
                          child: Text(cargo.toString().split('.').last),
                        );
                      }).toList(),
                      onChanged: (UserCargo? newValue) {
                        selectedCargo = newValue;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Cargo', border: OutlineInputBorder()),
                    )),
                const Spacer(),
                TextButton(onPressed: sendUser, child: const Text('CADASTRAR'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
