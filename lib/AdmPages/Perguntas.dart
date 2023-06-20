import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:login_page/model/Pergunta.dart';
import 'package:login_page/model/User.dart';
import 'package:login_page/model/Values.dart';

class PerguntaScreenADM extends StatelessWidget {
  final User loggedUser;

  const PerguntaScreenADM({Key? key, required this.loggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              heroTag: 'createPerguntasBtn',
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Criar Pergunta'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CriarPerguntaPage(loggedUser: loggedUser)
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            FloatingActionButton(
              heroTag: 'indexPerguntasBtn',
              child: const Icon(Icons.list_alt_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndexPerguntasPage(loggedUser: loggedUser)
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}



class CriarPerguntaPage extends StatefulWidget {
  final User loggedUser;
  const CriarPerguntaPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
    CriarPerguntaPageState createState() => CriarPerguntaPageState();

}

class CriarPerguntaPageState extends State<CriarPerguntaPage>{
  final _formKey = GlobalKey<FormState>();

  final TextEditingController enunciadoController = TextEditingController();
  final TextEditingController alternativaAController = TextEditingController();
  final TextEditingController alternativaBController = TextEditingController();
  final TextEditingController alternativaCController = TextEditingController();
  final TextEditingController alternativaDController = TextEditingController();
  String alternativaCorretaSelected = 'A';


  void sendPergunta(BuildContext context) async{
    String enunciado = enunciadoController.text;
    String alternativaA = alternativaAController.text;
    String alternativaB = alternativaBController.text;
    String alternativaC = alternativaCController.text;
    String alternativaD = alternativaDController.text;
    String alternativaCorreta = alternativaCorretaSelected;
    
    final URL = Uri.parse('$mainURL/perguntas');
    RegisterPergunta pergunta = RegisterPergunta(enunciado, alternativaA, alternativaB, alternativaC, alternativaD, alternativaCorreta, widget.loggedUser);
    String jsonPergunta = jsonEncode(pergunta.toJson());

    try{
      http.Response response = await http.post(URL,
          headers: {'Content-Type': 'application/json; charset=utf-8'}, body: jsonPergunta);
      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Pergunta cadastrada!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 400:
          const snackBar = SnackBar(
            content: Text('Requisição inválida: Cheque os campos.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 403:
          const snackBar = SnackBar(
            content: Text('Requisição inválida: usuário NÃO autorizado a realizar cadastros.'),
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
        title: const Text('Criar pergunta'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
              children:[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Insira um enunciado';
                          }
                          return null;
                        },
                        controller: enunciadoController,
                        decoration: const InputDecoration(
                          labelText: 'Enunciado',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Insira um texto para alternativa A';
                            }
                            return null;
                          },
                          maxLines: null,
                          controller: alternativaAController,
                          decoration: const InputDecoration(
                            labelText: 'Alternativa A',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Insira um texto para alternativa A';
                            }
                            return null;
                          },
                          controller: alternativaBController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            labelText: 'Alternativa B',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Insira um texto para alternativa A';
                            }
                            return null;
                          },
                          controller: alternativaCController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            labelText: 'Alternativa C',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Insira um texto para alternativa A';
                            }
                            return null;
                          },
                          controller: alternativaDController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            labelText: 'Alternativa D',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButton<String>(
                    value: alternativaCorretaSelected,
                    onChanged: (String? newValue) {
                      setState(() {
                        alternativaCorretaSelected = newValue!;
                      });
                    },
                    items: <String>['A', 'B', 'C', 'D'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                      TextButton(
                          child: const Text('Cadastrar Pergunta'),
                          onPressed:(){
                            if(_formKey.currentState!.validate()){
                            sendPergunta(context);
                        }
                      }
                      )
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class IndexPerguntasPage extends StatefulWidget {
  final User loggedUser;
  const IndexPerguntasPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  IndexPerguntasPageState createState() => IndexPerguntasPageState();
}

class IndexPerguntasPageState extends State<IndexPerguntasPage> {
  List<Pergunta> perguntasList = [];

  @override
  void initState() {
    getPerguntas();
    super.initState();
  }

  void getPerguntas() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/perguntas'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        perguntasList = jsonResponse.map((json) => Pergunta.fromJson(json)).toList();
      });

    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  void showConfirmationDialogPergunta(BuildContext context, Pergunta pergunta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Deseja excluir a pergunta ID: "${pergunta.id}"?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deletePergunta(context,pergunta.id);
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

  void deletePergunta(BuildContext context,int perguntaID) async{
    http.Response response = await http.delete(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/perguntas/$perguntaID'),
        headers: {'Content-Type': 'application/json'});

    try{
      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Pergunta excluída com sucesso.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            getPerguntas();
          });
          break;

        case 403:
          const snackBar = SnackBar(
            content: Text('Pergunta não excluída: Usuário sem permissão.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 409:
          const snackBar = SnackBar(
            content: Text('Pergunta não excluída: Está associado a um ou mais treinamentos.'),
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
    }
    catch(e){
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
        title: const Text('Todos as Perguntas'),
      ),
      body: ListView.builder(
        itemCount: perguntasList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Pergunta pergunta = perguntasList[index];
          return ListTile(
            leading: Text('${pergunta.id}'),
            title: Text(pergunta.enunciado),
            subtitle: Text('Gabarito: ${pergunta.alternativaCorreta}'),
            trailing: IconButton(
              icon: const Icon(Icons.clear_outlined),
              onPressed: (){
                showConfirmationDialogPergunta(context,pergunta);
              },
            ),
          );
        },
      ),
    );
  }
}
