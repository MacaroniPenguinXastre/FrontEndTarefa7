import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class LoginDTO{
   String email;
   String password;

   LoginDTO(this.email, this.password);
}

//TODO: Criar classe User