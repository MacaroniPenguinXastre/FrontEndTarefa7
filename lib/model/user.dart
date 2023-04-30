import 'dart:collection';

import 'package:flutter/widgets.dart';

class User{
  int id;
  String user;
  String password;
  //Construtor (obrigatório)
  User(this.id,this.user,this.password);
}

class RegistredUsers{
  SplayTreeSet<User> listUser;
  RegistredUsers(this.listUser);

  register(String user,String password){
    this.listUser.add(new User(this.listUser.length+1,user,password));
  }

  User? checkIfExists(String user, String password){
    if(this.listUser.contains(user) == false){
      print('Usuário não existe');
      return null;
    }

    return this.listUser.firstWhere((us) => us.password == password);
  }
}
TextEditingController userController = TextEditingController();
TextEditingController passwordController = TextEditingController();
