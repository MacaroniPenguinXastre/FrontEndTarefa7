import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/AlunoPages/AlunoAccess.dart';
import 'package:login_page/model/Curso.dart';
import 'package:login_page/model/Treinamento.dart';
import '../Service/TreinamentoService.dart';
import '../model/Quiz.dart';
import '../model/User.dart';
import '../model/Values.dart';
import 'package:intl/intl.dart';

class TreinamentosTelaADM extends StatelessWidget {
  final User loggedUser;
  const TreinamentosTelaADM({Key? key, required this.loggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CriarTreinamentoPage(loggedUser: loggedUser),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Criar Treinamento',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 200.0,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndexTreinamentoPage(loggedUser: loggedUser),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Listar Treinamentos',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CriarTreinamentoPage extends StatefulWidget {
  final User loggedUser;
  const CriarTreinamentoPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _CriarTreinamentoPageState createState() => _CriarTreinamentoPageState();
}

class _CriarTreinamentoPageState extends State<CriarTreinamentoPage> {
  final _formKey = GlobalKey<FormState>();

  final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
  List<Quiz>quizList = [];
  Quiz? selectedTesteAptidao;
  Quiz? selectedQuizCase1;
  Quiz? selectedQuizCase2;
  String labelButton = 'Cadastrar Treinamento';

  List<Curso> selectedCursosPrimeiraFase = [];
  List<Curso> selectedCursosSegundaFase = [];
  List<Curso> cursoList = [];

  final TextEditingController cargaHorariaTotalController = TextEditingController();
  final TextEditingController nomeComercialController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController dataInicioInscricaoController = TextEditingController();
  final TextEditingController dataFimInscricaoController = TextEditingController();
  final TextEditingController dataInicioTreinamentoController = TextEditingController();
  final TextEditingController dataFimTreinamentoController = TextEditingController();
  final TextEditingController quantidadeMinimaController = TextEditingController();
  final TextEditingController quantidadeMaximaController = TextEditingController();


  void sendTreinamento(BuildContext context,User user,RegisterTreinamento registerTreinamento)async{
    final URL = Uri.parse('$mainURL/adm/${user.id}/treinamentos');

    String jsonTreino = jsonEncode(registerTreinamento.toJson());

    try{
      http.Response response = await http.post(URL,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonTreino);

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Treinamento criado!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 400:
          const snackBar = SnackBar(
            content: Text('Requisição inválida: Cheque os campos'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
  void getQuizzes() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/quizzes'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        quizList = jsonResponse.map((json) => Quiz.fromJson(json)).toList();
      });
    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }
  void getCursos() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/cursos'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        cursoList = jsonResponse.map((json) => Curso.fromJson(json)).toList();
      });

    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getCursos();
    getQuizzes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Treinamento'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [

              sliverPaddingFormField(defaultTextFormField(nomeComercialController,'Nome Comercial')),
              sliverPaddingFormField(defaultTextFormField(descricaoController,'Descrição')),
              sliverPaddingFormField(defaultNumberFormField(cargaHorariaTotalController,'Carga Horária (em Horas)')),
              sliverPaddingFormField(defaultNumberFormField(quantidadeMinimaController,'Quantidade Mínima de Inscritos')),
              sliverPaddingFormField(defaultNumberFormField(quantidadeMaximaController,'Quantidade Máxima de Inscritos')),

              sliverTextPadding('Selecione um Quiz para o teste de aptidão'),
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: quizList.length,
                    (BuildContext context,int index){
                      final quiz = quizList[index];
                      return Card(
                        color: quiz == selectedTesteAptidao ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                        elevation: 4,
                        shadowColor: Theme.of(context).shadowColor,
                        child: ListTile(
                          leading: Text('${quiz.id}'),
                          title: Text(quiz.titulo),
                          subtitle: Text('Quantidades de perguntas associadas: ${quiz.perguntas.length}'),
                          trailing: const Icon(Icons.add_circle_outline),
                          onTap: ()=> setState(()=>selectedTesteAptidao == quiz ? selectedTesteAptidao = null : selectedTesteAptidao = quiz),
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
                      childCount: quizList.length,
                          (BuildContext context,int index){
                        final quiz = quizList[index];
                        return Card(
                          color: quiz == selectedQuizCase1 ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                          elevation: 4,
                          shadowColor: Theme.of(context).shadowColor,
                          child: ListTile(
                            leading: Text('${quiz.id}'),
                            title: Text(quiz.titulo),
                            subtitle: Text('Quantidades de perguntas associadas: ${quiz.perguntas.length}'),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState(()=>selectedQuizCase1 == quiz ? selectedQuizCase1 = null : selectedQuizCase1 = quiz),
                          ),
                        );
                      }
                  ),
                  itemExtent: 75.0
              ),
              sliverDivider(),
              sliverTextPadding('Selecione um Quiz para o case dois'),
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: quizList.length,
                          (BuildContext context,int index){
                        final quiz = quizList[index];
                        return Card(
                          color: quiz == selectedQuizCase2 ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                          elevation: 4,
                          shadowColor: Theme.of(context).shadowColor,
                          child: ListTile(
                            leading: Text('${quiz.id}'),
                            title: Text(quiz.titulo),
                            subtitle: Text('Quantidades de perguntas associadas: ${quiz.perguntas.length}'),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState(()=>selectedQuizCase2 == quiz ? selectedQuizCase2 = null : selectedQuizCase2 = quiz),
                          ),
                        );
                      }
                  ),
                  itemExtent: 75.0
              ),

              sliverDivider(),
              SliverToBoxAdapter(
                  child: DefaultDatePicker(
                      textEditingController: dataInicioInscricaoController,
                      labelText: 'Data de Inicio de inscrição')
              ),
              SliverToBoxAdapter(
                  child: DefaultDatePicker(
                      textEditingController: dataFimInscricaoController,
                      labelText: 'Data de Fim de inscrição')
              ),
              sliverDivider(),
              SliverToBoxAdapter(
                  child: DefaultDatePicker(
                      textEditingController: dataInicioTreinamentoController,
                      labelText: 'Data de Inicio do Treinamento')
              ),
              SliverToBoxAdapter(
                  child: DefaultDatePicker(
                      textEditingController: dataFimTreinamentoController,
                      labelText: 'Data de Fim do Treinamento')
              ),
              sliverDivider(),

              sliverTextPadding('Selecione cursos para a fase inicial'),
              SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
                  childCount: cursoList.length,
                      (BuildContext context,int index){
                    final curso = cursoList[index];
                    return Card(
                      color: selectedCursosPrimeiraFase.contains(curso) ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                        elevation: 4,
                        shadowColor: Theme.of(context).shadowColor,
                      child: ListTile(
                        leading: Text('${curso.id}'),
                        title: Text(curso.titulo),
                        subtitle: Text(curso.descricao),
                        trailing: const Icon(Icons.add_circle_outline),
                        onTap: ()=> setState((){
                          if(selectedCursosPrimeiraFase.contains(curso)){
                            selectedCursosPrimeiraFase.remove(curso);
                          }
                          selectedCursosPrimeiraFase.add(curso);
                        }
                      )
                    )
                    );
                  }
              ), itemExtent: 75.0),
              sliverDivider(),
              sliverTextPadding('Selecione cursos para a fase avançada'),
              SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
                  childCount: cursoList.length,
                      (BuildContext context,int index){
                    final curso = cursoList[index];
                    return Card(
                        color: selectedCursosSegundaFase.contains(curso) ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                        elevation: 4,
                        shadowColor: Theme.of(context).shadowColor,
                        child: ListTile(
                            leading: Text('${curso.id}'),
                            title: Text(curso.titulo),
                            subtitle: Text(curso.descricao),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState((){
                              if(selectedCursosSegundaFase.contains(curso)){
                                selectedCursosSegundaFase.remove(curso);
                              }
                              selectedCursosSegundaFase.add(curso);
                            }
                            )
                        )
                    );
                  }
              ), itemExtent: 75.0),
              SliverToBoxAdapter(
                child: FloatingActionButton.extended(heroTag: 'cadastrarTreinamento',
                    onPressed: ((){
                      if(_formKey.currentState!.validate()){
                        sendTreinamento(context,widget.loggedUser,RegisterTreinamento(
                            cargaHorariaTotal: int.parse(cargaHorariaTotalController.text),
                            nomeComercial: nomeComercialController.text,
                            descricao: descricaoController.text,
                            dataInicioInscricao:  DateTime.parse(dataInicioInscricaoController.text),
                            dataFimInscricao: DateTime.parse(dataFimInscricaoController.text),
                            dataInicioTreinamento: DateTime.parse(dataInicioTreinamentoController.text),
                            dataFimTreinamento: DateTime.parse(dataFimTreinamentoController.text),
                            quantidadeMinima: int.parse(quantidadeMinimaController.text),
                            quantidadeMaxima: int.parse(quantidadeMaximaController.text),
                            testeAptidao: selectedTesteAptidao!,
                            faseIntrodutorio: selectedCursosPrimeiraFase,
                            primeiroCase: selectedQuizCase1!,
                            faseAvancada: selectedCursosSegundaFase,
                            segundoCase: selectedQuizCase2!));
                      }
                    }),
                    icon: const Icon(Icons.send_outlined),
                    label: Text(labelButton)),
              )
            ],
          ),
        ),
      ),
    );
  }

}


class EditarTreinamentoPage extends StatefulWidget {
  final User loggedUser;
  final Treinamento treinamento;
  const EditarTreinamentoPage({Key? key, required this.loggedUser,required this.treinamento}) : super(key: key);

  @override
  _EditarTreinamentoPageState createState() => _EditarTreinamentoPageState();
}

class _EditarTreinamentoPageState extends State<EditarTreinamentoPage>{

  final _formKey = GlobalKey<FormState>();

  final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
  List<Quiz>quizList = [];
  Quiz? selectedTesteAptidao;
  Quiz? selectedQuizCase1;
  Quiz? selectedQuizCase2;
  String labelButton = 'Salvar Alterações';

  List<Curso> selectedCursosPrimeiraFase = [];
  List<Curso> selectedCursosSegundaFase = [];
  List<Curso> cursoList = [];

  final TextEditingController cargaHorariaTotalController = TextEditingController();
  final TextEditingController nomeComercialController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController dataInicioInscricaoController = TextEditingController();
  final TextEditingController dataFimInscricaoController = TextEditingController();
  final TextEditingController dataInicioTreinamentoController = TextEditingController();
  final TextEditingController dataFimTreinamentoController = TextEditingController();
  final TextEditingController quantidadeMinimaController = TextEditingController();
  final TextEditingController quantidadeMaximaController = TextEditingController();


  void updateTreinamento(BuildContext context,User user,Treinamento treinamento)async{
    final URL = Uri.parse('$mainURL/adm/${user.id}/treinamentos/${treinamento.id}');
    String jsonTreino = jsonEncode(treinamento.toJson());

    try{
      http.Response response = await http.put(URL,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonTreino);

      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Treinamento alterado!'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;

        case 400:
          const snackBar = SnackBar(
            content: Text('Requisição inválida: Cheque os campos'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
  void getQuizzes() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/quizzes'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        quizList = jsonResponse.map((json) => Quiz.fromJson(json)).toList();
      });
    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }
  void getCursos() async {
    http.Response response = await http.get(
        Uri.parse('$mainURL/adm/${widget.loggedUser.id}/cursos'),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        cursoList = jsonResponse.map((json) => Curso.fromJson(json)).toList();
      });

    }
    else{
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    cargaHorariaTotalController.text = widget.treinamento.cargaHorariaTotal.toString();
    nomeComercialController.text = widget.treinamento.nomeComercial;
    descricaoController.text = widget.treinamento.descricao;
    dataInicioInscricaoController.text = dateFormat.format(widget.treinamento.dataInicioInscricao);
    dataFimInscricaoController.text = dateFormat.format(widget.treinamento.dataFimInscricao);
    dataInicioTreinamentoController.text = dateFormat.format(widget.treinamento.dataInicioTreinamento);
    dataFimTreinamentoController.text = dateFormat.format(widget.treinamento.dataFimTreinamento);
    quantidadeMinimaController.text = widget.treinamento.quantidadeMinima.toString();
    quantidadeMaximaController.text = widget.treinamento.quantidadeMaxima.toString();
    selectedCursosPrimeiraFase = widget.treinamento.faseIntrodutorio;
    selectedCursosSegundaFase = widget.treinamento.faseAvancada;
    selectedTesteAptidao = widget.treinamento.testeAptidao;
    selectedQuizCase1 = widget.treinamento.primeiroCase;
    selectedQuizCase2 = widget.treinamento.segundoCase;

    getCursos();
    getQuizzes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Treinamento'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [

              sliverPaddingFormField(defaultTextFormField(nomeComercialController,'Nome Comercial')),
              sliverPaddingFormField(defaultTextFormField(descricaoController,'Descrição')),
              sliverPaddingFormField(defaultNumberFormField(cargaHorariaTotalController,'Carga Horária (em Horas)')),
              sliverPaddingFormField(defaultNumberFormField(quantidadeMinimaController,'Quantidade Mínima de Inscritos')),
              sliverPaddingFormField(defaultNumberFormField(quantidadeMaximaController,'Quantidade Máxima de Inscritos')),

              sliverTextPadding('Selecione um Quiz para o teste de aptidão'),
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(

                      childCount: quizList.length,
                          (BuildContext context,int index){
                        final quiz = quizList[index];
                        return Card(
                          color: quiz == selectedTesteAptidao ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                          elevation: 4,
                          shadowColor: Theme.of(context).shadowColor,
                          child: ListTile(
                            leading: Text('${quiz.id}'),
                            title: Text(quiz.titulo),
                            subtitle: Text('Quantidades de perguntas associadas: ${quiz.perguntas.length}'),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState(()=>selectedTesteAptidao == quiz ? selectedTesteAptidao = null : selectedTesteAptidao = quiz),
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
                      childCount: quizList.length,
                          (BuildContext context,int index){
                        final quiz = quizList[index];
                        return Card(
                          color: quiz == selectedQuizCase1 ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                          elevation: 4,
                          shadowColor: Theme.of(context).shadowColor,
                          child: ListTile(
                            leading: Text('${quiz.id}'),
                            title: Text(quiz.titulo),
                            subtitle: Text('Quantidades de perguntas associadas: ${quiz.perguntas.length}'),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState(()=>selectedQuizCase1 == quiz ? selectedQuizCase1 = null : selectedQuizCase1 = quiz),
                          ),
                        );
                      }
                  ),
                  itemExtent: 75.0
              ),
              sliverDivider(),
              sliverTextPadding('Selecione um Quiz para o case dois'),
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: quizList.length,
                          (BuildContext context,int index){
                        final quiz = quizList[index];
                        return Card(
                          color: quiz == selectedQuizCase2 ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                          elevation: 4,
                          shadowColor: Theme.of(context).shadowColor,
                          child: ListTile(
                            leading: Text('${quiz.id}'),
                            title: Text(quiz.titulo),
                            subtitle: Text('Quantidades de perguntas associadas: ${quiz.perguntas.length}'),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState(()=>selectedQuizCase2 == quiz ? selectedQuizCase2 = null : selectedQuizCase2 = quiz),
                          ),
                        );
                      }
                  ),
                  itemExtent: 75.0
              ),

              sliverDivider(),
              SliverToBoxAdapter(
                  child: DefaultDatePicker(
                      textEditingController: dataInicioInscricaoController,
                      labelText: 'Data de Inicio de inscrição')
              ),
              SliverToBoxAdapter(
                  child: DefaultDatePicker(
                      textEditingController: dataFimInscricaoController,
                      labelText: 'Data de Fim de inscrição')
              ),
              sliverDivider(),
              SliverToBoxAdapter(
                  child: DefaultDatePicker(
                      textEditingController: dataInicioTreinamentoController,
                      labelText: 'Data de Inicio do Treinamento')
              ),
              SliverToBoxAdapter(
                  child: DefaultDatePicker(
                      textEditingController: dataFimTreinamentoController,
                      labelText: 'Data de Fim do Treinamento')
              ),
              sliverDivider(),

              sliverTextPadding('Selecione cursos para a fase inicial'),
              SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
                  childCount: cursoList.length,
                      (BuildContext context,int index){
                    final curso = cursoList[index];
                    return Card(
                        color: selectedCursosPrimeiraFase.contains(curso) ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                        elevation: 4,
                        shadowColor: Theme.of(context).shadowColor,
                        child: ListTile(
                            leading: Text('${curso.id}'),
                            title: Text(curso.titulo),
                            subtitle: Text(curso.descricao),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState((){
                              if(selectedCursosPrimeiraFase.contains(curso)){
                                selectedCursosPrimeiraFase.remove(curso);
                              }
                              selectedCursosPrimeiraFase.add(curso);
                            }
                            )
                        )
                    );
                  }
              ), itemExtent: 75.0),
              sliverDivider(),
              sliverTextPadding('Selecione cursos para a fase avançada'),
              SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
                  childCount: cursoList.length,
                      (BuildContext context,int index){
                    final curso = cursoList[index];
                    return Card(
                        color: selectedCursosSegundaFase.contains(curso) ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                        elevation: 4,
                        shadowColor: Theme.of(context).shadowColor,
                        child: ListTile(
                            leading: Text('${curso.id}'),
                            title: Text(curso.titulo),
                            subtitle: Text(curso.descricao),
                            trailing: const Icon(Icons.add_circle_outline),
                            onTap: ()=> setState((){
                              if(selectedCursosSegundaFase.contains(curso)){
                                selectedCursosSegundaFase.remove(curso);
                              }
                              selectedCursosSegundaFase.add(curso);
                            }
                            )
                        )
                    );
                  }
              ), itemExtent: 75.0),
              SliverToBoxAdapter(
                child: FloatingActionButton.extended(heroTag: 'cadastrarTreinamento',
                    onPressed: ((){
                      if(_formKey.currentState!.validate()){
                        updateTreinamento(context,widget.loggedUser,Treinamento(
                            id:widget.treinamento.id,
                            cargaHorariaTotal: int.parse(cargaHorariaTotalController.text),
                            nomeComercial: nomeComercialController.text,
                            descricao: descricaoController.text,
                            dataInicioInscricao:  DateTime.parse(dataInicioInscricaoController.text),
                            dataFimInscricao: DateTime.parse(dataFimInscricaoController.text),
                            dataInicioTreinamento: DateTime.parse(dataInicioTreinamentoController.text),
                            dataFimTreinamento: DateTime.parse(dataFimTreinamentoController.text),
                            quantidadeMinima: int.parse(quantidadeMinimaController.text),
                            quantidadeMaxima: int.parse(quantidadeMaximaController.text),
                            testeAptidao: selectedTesteAptidao!,
                            faseIntrodutorio: selectedCursosPrimeiraFase,
                            primeiroCase: selectedQuizCase1!,
                            faseAvancada: selectedCursosSegundaFase,
                            segundoCase: selectedQuizCase2!));
                      }
                    }),
                    icon: const Icon(Icons.send_outlined),
                    label: Text(labelButton)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IndexTreinamentoPage extends StatefulWidget {
  final User loggedUser;
  const IndexTreinamentoPage({Key? key, required this.loggedUser}) : super(key: key);
  @override
  _IndexTreinamentoPageState createState() => _IndexTreinamentoPageState();
}

class _IndexTreinamentoPageState extends State<IndexTreinamentoPage> {
  List<Treinamento>treinoList = [];
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

  @override
  void initState() {
    getTreinos();
    super.initState();
  }
  void deleteTreino(BuildContext context,int userID,int treinamentoID)async {
    final _deleteURL = Uri.parse('$mainURL/adm/$userID/treinamentos/$treinamentoID');

    http.Response response = await http.delete(_deleteURL, headers: {'Content-Type': 'application/json'});
    try{
      switch(response.statusCode){
        case 200:
          const snackBar = SnackBar(
            content: Text('Treinamento deletado com sucesso.'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            getTreinos();
          });
          break;
        case 409:
          const snackBar = SnackBar(
            content: Text('Não foi possível deletar treinamento: possui mais de um aluno ou vaga de emprego associados.'),
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

  void showConfirmationDialogPergunta(BuildContext context, Treinamento treinamento) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Deseja excluir o treinamento ID: "${treinamento.id}"?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deleteTreino(context,widget.loggedUser.id,treinamento.id);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView.builder(
        itemCount: treinoList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Treinamento treino = treinoList[index];
          return Card(
            child: ListTile(
              leading: Text('${treino.id}'),
              title: Text(treino.nomeComercial),
              subtitle: Text(treino.descricao),
              trailing: PopupMenuButton(
                onSelected: (String value){
                  switch(value){
                    case 'delete':
                      showConfirmationDialogPergunta(context,treino);
                      break;
                    case 'edit':
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditarTreinamentoPage(treinamento: treino, loggedUser: widget.loggedUser,))
                      );

                      break;
                    case 'info':
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TreinamentoDetalhesPage(treinamento: treino))
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
        },
      ),
    );
  }
}

class TreinamentoDetalhesPage extends StatelessWidget {
  final Treinamento treinamento;

  const TreinamentoDetalhesPage({super.key,required this.treinamento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Treinamento'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shadowColor: Theme.of(context).shadowColor,
                  child: Text('Id do treinamento: ${treinamento.id}'),
                )
              ],
            ),
          )
        )
      )
    );
  }
}

