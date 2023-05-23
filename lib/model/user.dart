import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class LoginDTO{
   String email;
   String password;

   LoginDTO(this.email, this.password);
}

enum UserCargo{
   ALUNO,ADM,MENTOR,EMPRESA_PARCEIRA
}


//Por questões de segurança, senha NÃO é armazenada.
class User {
   int id;
   String cargo;
   String email;
   String nome;

   User(this.id, this.cargo, this.email, this.nome);

   factory User.fromJson(Map<String, dynamic> json) {
      return User(
         json['id'],
         json['cargo'],
         json['email'],
         json['nome'],
      );
   }

   Map<String, dynamic> toJson() {
      return {
         'nome': nome,
         'email': email,
         'cargo': cargo
      };
   }
}