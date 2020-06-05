import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:siv1/pages/LoginPage.dart';

class Cadastro extends _CadUsuarioState{

}

class CadUsuario extends StatefulWidget {

  @override
  _CadUsuarioState createState() => _CadUsuarioState();
}

class _CadUsuarioState extends State<CadUsuario> {

  final nome_controller = TextEditingController();       // Recupera Dados da TextField NOME
  final email_controller = TextEditingController();      // Recupera Dados da TextField EMAIL
  final senha_controller = TextEditingController();      // Recupera Dados da TextField SENHA
  final confsenha_controller = TextEditingController();  // Recupera Dados da TextField CONFSENHA

  Future user() async{
    String nome = nome_controller.text;
    String email = email_controller.text;
    String senha = senha_controller.text;

    var map = Map<String, dynamic>();
    map['name'] = nome;
    map['email'] = email;
    map['password'] = senha;

    var response = await http.post(
        'http://smartignition01.ddns.net:9000/insert_remoto.php',
        body: map);

    var msg = jsonDecode(response.body);

    if(response.statusCode  == 200){
      Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()));
    }else{
      print(msg);
    }

/*
    var response = await http.post(
        'http://smartignition01.ddns.net:9000/insert_remoto.php',
        body: json.encode(
            {'name': nome,
              'email': email,
              'password': senha,
            }
        ));

    var msg = jsonDecode(response.body);
    print(msg);
    if(msg == 'Data Saved Successfully'){
      Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()));
    }else{
      print(msg);
    }

 */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 45, left: 40, right: 40, bottom: 10),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              width: 170,
              height: 170,
              alignment: Alignment(0.0, 1.25),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage('assent/Usuario.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),

              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    stops: [0.15, 1.0],
                    colors: [
                      Color(0xFFF0088D2),
                      Color(0xFFF23A9F2),
                    ],
                  ),
                    border: Border.all(
                      width: 4,
                      color: Colors.white,
                    ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(56)
                  ),
                ),

                child: SizedBox.expand(
                  child: FlatButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: (){},
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: nome_controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                )
              ),
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: email_controller,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                )
              ),
            ),

            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: senha_controller,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                )
              ),
            ),

            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: confsenha_controller,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                )
              ),
         /*     onChanged: (String conf_senha){
                if(conf_senha != senha_controller.text){
                  print(conf_senha);
                }
              },
         */   ),

            SizedBox(
              height: 20,
            ),

            Container(
              height: 60,
              alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        stops: [0.3, 1],
                        colors:[
                          Color(0xFFF0088D2),
                          Color(0xFFF23A9F2),
                        ]
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(5)
                    )
                ),

                child: SizedBox.expand(
                  child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Cadastrar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),

                          Container(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.asset('assent/Add_Usuario.png'),
                            ),
                          )
                        ],
                      ),
                      onPressed: user
                  ),
                )

            )

          ],
        ),
      ),
    );
  }
}
