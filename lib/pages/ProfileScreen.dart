import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siv1/pages/GeolocationPage.dart';
import 'package:siv1/pages/LoginPage.dart';

class command {

  Future block() async {
    var map = Map<String, dynamic>();
    map['block'] = '0';

    var response = await http.post(
        'http://smartignition01.ddns.net:9000/insert-command_remoto.php',
        body: map);

    var msg = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Bloqueado');
    } else {
      print('Erro');
    }
  }

  Future unlock() async{

    var map = Map<String, dynamic>();
    map['unlock'] = '1';

    var response = await http.post(
        'http://smartignition01.ddns.net:9000/insert-command_remoto.php',
        body: map);

    var msg = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(msg);
    } else {
      print('Erro');
    }
  }

}

class ProfileScreen extends StatefulWidget {

  String email;
  ProfileScreen(this.email);        // Pega Valor Recebido Pela String email

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: new Text('My Profile')
      ),

      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text('Thiago Dias Olimpio'),
                accountEmail: new Text('thiago.olimpio@hotmail.com'),
                currentAccountPicture: new CircleAvatar(
                  child: new Image.asset('assent/Usuario.png'),
                ),
            )

          ],
        )
      ),

      body: Container(
        padding: EdgeInsets.only(top: 45, left: 40, right: 40, bottom: 10),
        color: Colors.white,
        child: ListView(
          children: <Widget>[

            SizedBox(
              width: 170,
              height: 170,
              child: Image.asset('assent/Usuario.png'),
            ),

            SizedBox(
              height: 40,
            ),

            Container(
              height: 20,
              child: Text(
                'Thiago Dias Olimpio',
                style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                ),
              ),
             ),

            SizedBox(
              height: 5,
            ),

            Container(
              height: 50,
              child: Text(
                'HYUNDAI HB20 COMFORT PLUS 1.0 12V 4P. FLEX',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(5)
                )
              ),

              child: SizedBox.expand(
                child: FlatButton(
                  child: Text('Bloquear',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                    onPressed: command().block
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(5)
                )
              ),

              child: SizedBox.expand(
                child: FlatButton(
                  child: Text('Desbloquear',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: command().unlock
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)
                  )
              ),

              child: SizedBox.expand(
                child: FlatButton(
                    child: Text('Rastrear',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GeolocationPage()));
                    }
                ),
              ),
            )

          ],
        ),
    ),
    );
  }
}
