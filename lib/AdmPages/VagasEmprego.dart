import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/model/VagasEmprego.dart';
import '../model/Treinamento.dart';
import '../model/User.dart';
import '../model/Values.dart';

class VagasTelaADM extends StatelessWidget{
  final User loggedUser;
  const VagasTelaADM({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                heroTag: 'createVagaEmpregoBtn',
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Criar Vaga de Emprego'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CriarVagasEmpregoPage(loggedUser: loggedUser)
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              FloatingActionButton(
                heroTag: 'indexVagaEmpregoBtn',
                child: const Icon(Icons.list_alt_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IndexVagasEmpregoPage(loggedUser: loggedUser)
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IndexVagasEmpregoPage extends StatefulWidget {
  final User loggedUser;
  const IndexVagasEmpregoPage({Key? key, required this.loggedUser}) : super(key: key);
  @override
  _IndexVagasEmpregoPageState createState() => _IndexVagasEmpregoPageState();
}

class _IndexVagasEmpregoPageState extends State<IndexVagasEmpregoPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          
        ),
      ),
    );
  }
  
}

class CriarVagasEmpregoPage extends StatefulWidget{
  const CriarVagasEmpregoPage({super.key, required User loggedUser});

  @override
  CriarVagasEmpregoPageState createState() => CriarVagasEmpregoPageState();
}

class CriarVagasEmpregoPageState extends State<CriarVagasEmpregoPage>{
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController atividadesController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController faixaSalarialController = TextEditingController();

  List<User> userList = [];
  User? selectedUser;

  List<Treinamento>treinoList = [];
  Treinamento? selectedTreinamento;

  void getTreinos() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/treinamentos'),
        headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        treinoList = jsonResponse.map((json) => Treinamento.fromJson(json)).toList();
      });
    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  void getUser() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL/users/parceiros/vagas'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        userList = jsonResponse.map((json) => User.fromJson(json)).toList();
      });
    } else {
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getTreinos();
    getUser();
    super.initState();
  }

  void sendVagaEmprego(BuildContext context,RegisterVagasEmprego registerVagasEmprego)async{
    final URL = Uri.parse('$mainURL/vagas');
    String jsonVagas = jsonEncode(registerVagasEmprego.toJson());

    try{
      http.Response response = await http.post(URL,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonVagas);

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Vaga de emprego criada!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case 403:
          const snackBar = SnackBar(
            content: Text('Usuário associado sem permissão!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case 400:
          const snackBar = SnackBar(
            content: Text('Erro de Requisição!'),
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
        title: const Text('Criar Vaga de Emprego'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              sliverPaddingFormField(defaultTextFormField(tituloController,'Título')),
              sliverPaddingFormField(defaultTextFormField(atividadesController,'Atividade a exercer')),
              sliverPaddingFormField(defaultTextFormField(descricaoController,'Descrição')),
              sliverPaddingFormField(defaultNumberFormField(faixaSalarialController,'Faixa Salarial')),

              sliverTextPadding('Selecione a empresa parceira'),
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: userList.length,
                          (BuildContext context,int index){
                        final user = userList[index];
                        return Card(
                          color: user == selectedUser ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                          elevation: 4,
                          shadowColor: Theme.of(context).shadowColor,
                          child: ListTile(
                            leading: Text('${user.id}'),
                            title: Text(user.nome),
                            subtitle: Text('Email: ${user.email}'),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState(()=>selectedUser == user ? selectedUser = null : selectedUser = user),
                          ),
                        );
                      }
                  ),
                  itemExtent: 75.0
              ),
              sliverDivider(),
              sliverTextPadding('Selecione um Quiz para o case um'),
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: treinoList.length,
                          (BuildContext context,int index){
                        final treino = treinoList[index];
                        return Card(
                          color: treino == selectedTreinamento ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                          elevation: 4,
                          shadowColor: Theme.of(context).shadowColor,
                          child: ListTile(
                            leading: Text('${treino.id}'),
                            title: Text(treino.nomeComercial),
                            subtitle: Text(treino.descricao),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState(()=>selectedTreinamento == treino ? selectedTreinamento = null : selectedTreinamento = treino),
                          ),
                        );
                      }
                  ),
                  itemExtent: 75.0
              ),
              SliverToBoxAdapter(
                child: FloatingActionButton.extended(heroTag: 'cadastrarVagaEmprego',
                    onPressed: ((){
                      if(_formKey.currentState!.validate()){
                        sendVagaEmprego(context,
                            RegisterVagasEmprego(
                              titulo: tituloController.text,
                              atividades: atividadesController.text, empresa: selectedUser!,
                              treinamentoRequisito: selectedTreinamento!, faixaSalarial: double.parse(faixaSalarialController.text),
                            ));
                      }
                    }),
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Cadastrar Vaga de Emprego')),
              )
            ],
          ),
        ),
      ),
    );
  }
}