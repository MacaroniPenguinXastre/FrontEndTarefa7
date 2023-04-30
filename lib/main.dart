
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/model/HomePage.dart';
import 'model/user.dart';

User usuario1 = new User(1,"Marcato","Batata");
List<User> lista01 = <User>[];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      //Define tema escuro
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState() {
    return loginPage();
  }
}

class loginPage extends State<MainPage>{

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    final errorMessage error = errorMessage();

    return Scaffold(
      body: Container(
        width: largura,
        height: altura,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Image.asset('images/pato.jpg',
                    fit: BoxFit.fill,height: altura,
              )
            ),
              Container(
                color: Colors.black38,
                width: 350,
                height: altura,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Se logue'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20.0),
                      child: TextFormField(
                        controller: userController,
                        decoration: const InputDecoration(
                          label: Text('Usuário'),
                          border: OutlineInputBorder()
                        ),
                        validator: (user){
                          if(user == null){
                            return 'Digite um usuário';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text('Senha'),
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20.0),
                      child: Container(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            String username = userController.text;
                            String password = passwordController.text;

                            if(username == usuario1.user && username != null){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage(),)
                              );
                            }
                            else {
                              error.setError("Usuário ou senha incorretos");
                            }
                            },
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: error.error,
                      builder: (context, String value,_) => Text(value,
                      style: TextStyle(
                        color: Colors.red
                      ),),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class errorMessage extends ChangeNotifier{
  final ValueNotifier<String> error = ValueNotifier("");

  setError(String message){
    error.value = message;
    notifyListeners();
  }
}