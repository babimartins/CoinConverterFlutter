import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=1b1b40f0";

void main() async {  

  print(await getData());

  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body)["results"]["currencies"];
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...", 
                  style: TextStyle(
                    color: Colors.amber, 
                    fontSize: 25.0
                  ),
                ),
              );
            default:
              if(snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados :(", 
                    style: TextStyle(
                      color: Colors.amber, 
                      fontSize: 25.0
                    ),
                  ),
                );
              }
              else {
                dolar = snapshot.data["USD"]["buy"];
                euro = snapshot.data["EUR"]["buy"];
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Reais",
                          labelStyle: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}





//theme: ThemeData(
//  inputDecorationTheme: InputDecorationTheme(
//    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
//  )
//)