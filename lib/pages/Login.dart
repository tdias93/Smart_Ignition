import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siv1/pages/ProfileScreen.dart';

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage2> {

  final emailController = TextEditingController();       // Recupera dados da TextField E-mail
  final passwordController = TextEditingController();    // Recupera dados da TextFiels Senha

  Future login () async{

    String email = emailController.text;            //Pega Dados da TextField E-mail
    String password = passwordController.text;      //Pega Dados da TextField Senha

    var response = await http.post(
        'http://smartignition01.ddns.net:9000/login_user.php',     // Endereço da API
        body: json.encode(
            {'email': email, 'password' : password}                // Dados Passados p/ a API
        ));

    var message = jsonDecode(response.body);                       // Pega Retorno da API

    if(message == 'Login Matched'){

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(email))
      );

    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 45, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[

            SizedBox(
              width: 170,
              height: 170,
              child: Image.asset('assent/SI-logo.png'),
            ),

            SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,     //Formata Teclado p/ E-mail
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),

            Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: FlatButton(
                    child: Text(
                      'Recuperar Senha',
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () {}
                )
            ),

            SizedBox(
              height: 20,
            ),

            Container(
                height: 60,
                alignment: Alignment.centerLeft,
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
                          Text('Login',
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
                              child: Image.asset('assent/car.png'),
                            ),
                          )
                        ],
                      ),
                      onPressed: login
                  ),
                )
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0xFF3C5A99),
                borderRadius: BorderRadius.all(
                    Radius.circular(5)
                ),
              ),

              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Login com Facebook',
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
                          child: Image.asset('assent/fb-icon.png'),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              height: 40,
              child: FlatButton(
                child: Text(
                  'Cadastre-se',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {},
              ),
            )

          ],
        ),
      ),
    );
  }
}
