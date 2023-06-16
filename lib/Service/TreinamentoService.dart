import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../model/Treinamento.dart';
import '../model/User.dart';
import '../model/Values.dart';



void updateTreinamento(BuildContext context,int userID,int treinamentoID,RegisterTreinamento registerTreinamento) async {
  final URL = Uri.parse('/adm/$userID/treinamentos/$treinamentoID');


}