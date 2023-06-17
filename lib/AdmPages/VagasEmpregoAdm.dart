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
  List<VagasEmprego>listVagas = [];

  void deleteVagasEmprego(BuildContext context,int userID,int vagaID)async {
    final _deleteURL = Uri.parse('$mainURL/admin/$userID/vagas/$vagaID');

    http.Response response = await http.delete(_deleteURL, headers: {'Content-Type': 'application/json'});
    try{
      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Vaga de emprego deletada com sucesso.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            initState();
          });
          break;
        case 409:
          const snackBar = SnackBar(
            content: Text('Não foi possível deletar vaga de emprego: possui mais de um candidato.'),
            duration: Duration(seconds: 4),
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

  void getVagasEmprego(BuildContext context,int userID)async{
    final URL = Uri.parse('$mainURL/parceiro/$userID/vagas');
    try{
      http.Response response = await http.get(
        URL,
        headers: {'Content-Type': 'application/json'},
      );

      switch(response.statusCode){
        case 200:
          List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
          setState(() {
            listVagas = jsonResponse.map((json) => VagasEmprego.fromJson(json)).toList();
          });
          break;

        case 204:

          break;
        case 403:
          const snackBar = SnackBar(
            content: Text('Você não tem permissão para criar um treinamento.'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        default:
          const snackBar = SnackBar(
            content: Text('Erro de Requisição'),
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

  void showConfirmationDialogPergunta(BuildContext context, VagasEmprego vagasEmprego) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Deseja excluir a vaga de emprego ID: "${vagasEmprego.id}"?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deleteVagasEmprego(context,widget.loggedUser.id,vagasEmprego.id);
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

  @override
  void initState() {
    getVagasEmprego(context,widget.loggedUser.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as vagas de emprego'),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: listVagas.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            VagasEmprego vagasEmprego = listVagas[index];
            return Card(
              child: ListTile(
                  leading: Text('${vagasEmprego.id}'),
                  title: Text(vagasEmprego.titulo),
                  subtitle: Text('Atividade a exercer: ${vagasEmprego.atividades}\nEmpresa: ${vagasEmprego.empresa.nome}'),
                  isThreeLine: true,
                  trailing: PopupMenuButton(
                    onSelected: (String value){
                      switch(value){
                        case 'delete':
                          showConfirmationDialogPergunta(context,vagasEmprego);
                          break;
                        case 'edit':
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EditarVagasEmpregoPage(vagasEmprego: vagasEmprego, loggedUser: widget.loggedUser))
                          );
                          break;
                        case 'info':
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => VagasEmpregoDetalhesPage(vagasEmprego: vagasEmprego,loggedUser: widget.loggedUser))
                          );
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return const[
                        PopupMenuItem(value: 'info',
                            child: Row(
                                children: [
                                  Icon(Icons.info_outline),
                                  VerticalDivider(),
                                  Text('Detalhes')
                                ]
                            )
                        ),
                        PopupMenuItem(value: 'edit',
                            child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  VerticalDivider(),
                                  Text('Editar')
                                ]
                            )),
                        PopupMenuItem(value: 'delete',child:Row(
                            children:[
                              Icon(Icons.delete_outline),
                              VerticalDivider(),
                              Text('Delete')
                            ]))
                      ];
                    },
                  )
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) => const Divider(),
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
              sliverTextPadding('Selecione o treinamento pré-requisito'),
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


class VagasEmpregoDetalhesPage extends StatelessWidget {
  final VagasEmprego vagasEmprego;
  final User loggedUser;
  const VagasEmpregoDetalhesPage({super.key,required this.vagasEmprego,required this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
          child: CustomScrollView(
              slivers: [
                sliverTextCardPadding('ID da Vaga: ${vagasEmprego.id}'),
                sliverTextCardPadding(vagasEmprego.titulo),
                sliverTextCardPadding('Empresa contratante: ${vagasEmprego.empresa}'),
                sliverTextCardPadding('Atividade a exercer: ${vagasEmprego.atividades}'),
                sliverTextCardPadding('Faixa salarial: ${vagasEmprego.faixaSalarial}'),
                sliverTextCardPadding('Treinamento pré-requisito: ${vagasEmprego.treinamentoRequisito.id}'),
                sliverDivider(),
                sliverTextCardPadding('Candidatos'),
                sliverTextCardPadding('Quantidade:${vagasEmprego.candidatos.length}'),
                SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
                    childCount: vagasEmprego.candidatos.length,
                        (BuildContext context,int index){
                      User candidato  = vagasEmprego.candidatos[index];
                      return Card(
                          elevation: 4,
                          child: ListTile(
                            leading: Text('${candidato.id}'),
                            title: Text(candidato.nome),
                            subtitle: Text(candidato.cargo),
                          )
                      );
                    }
                ), itemExtent: 75.0),
              ]
          )
      ),
    );
  }
}

class EditarVagasEmpregoPage extends StatefulWidget {
  final VagasEmprego vagasEmprego;
  final User loggedUser;
  const EditarVagasEmpregoPage({Key? key, required this.vagasEmprego,required this.loggedUser}) : super(key: key);

  @override
  EditarVagasEmpregoPageState createState() => EditarVagasEmpregoPageState();
}

class EditarVagasEmpregoPageState extends State<EditarVagasEmpregoPage>{
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController atividadesController = TextEditingController();
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

  void getParceiros() async {
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
    tituloController.text = widget.vagasEmprego.titulo;
    atividadesController.text = widget.vagasEmprego.atividades;
    faixaSalarialController.text = widget.vagasEmprego.faixaSalarial.toString();
    selectedUser = widget.vagasEmprego.empresa;
    getTreinos();
    getParceiros();
    super.initState();
  }

  void updateVagaEmprego(BuildContext context,VagasEmprego vagasEmprego)async{
    final URL = Uri.parse('$mainURL/admin/${widget.loggedUser.id}/vagas/${widget.vagasEmprego.id}');
    String jsonVagas = jsonEncode(vagasEmprego.toJson());

    try{
      http.Response response = await http.put(URL,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonVagas);

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('As alterações foram salvas com sucesso!'),
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
        title: const Text('Editar Vaga de Emprego'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              sliverPaddingFormField(defaultTextFormField(tituloController,'Título')),
              sliverPaddingFormField(defaultTextFormField(atividadesController,'Atividade a exercer')),
              sliverPaddingFormField(defaultDecimalFormField(faixaSalarialController,'Faixa Salarial')),

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
              sliverTextPadding('Selecione o treinamento pré-requisito'),
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
                        updateVagaEmprego(context,
                            VagasEmprego(
                              id: widget.loggedUser.id,
                              titulo: tituloController.text,
                              atividades: atividadesController.text, empresa: selectedUser!,
                              treinamentoRequisito: selectedTreinamento!, faixaSalarial: double.parse(faixaSalarialController.text),
                              candidatos: userList
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