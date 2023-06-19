import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../model/Treinamento.dart';
import '../model/User.dart';
import '../model/Values.dart';

class QuizRespostasDTO {
  Map<int, String> respostas;

  QuizRespostasDTO({required this.respostas});

  Map<String, dynamic> toJson() {
    Map<String, String> respostasString = respostas.map(
          (key, value) => MapEntry(key.toString(), value),
    );

    return {
      'respostas': respostasString,
    };
  }
}