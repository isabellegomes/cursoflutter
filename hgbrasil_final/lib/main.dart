import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hgbrasil_final/uteis/Componentes.dart';
import 'package:http/http.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController controladorCidade = TextEditingController();
  GlobalKey<FormState> cForm = GlobalKey<FormState>();
  String temperatura = "Temperatura";
  String descricao = "Descricao";
  String cidade = "Cidade";
  String data = "Data";



  Function codigoCidade = (( String){
    if(String.isEmpty)
      return "Informe o Código ou nome da sua cidade";

    return null;
  });

  clicouNoBotao() async{
    if (!cForm.currentState.validate())
      return ;
    String url = "https://api.hgbrasil.com/weather?key=${controladorCidade.text}/";
    Response resposta = await get(url);
    Map tempo = json.decode(resposta.body);
    temperatura = '${tempo ["results"]["temp"]} graus';
    // conforme na API
    setState(() {
      descricao = tempo["description"];
      cidade = tempo["city"];
      data = tempo ["date"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: cForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/imgs/logotempo.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Componentes.caixaDeTexto("Cidade", "Informe a Cidade (sem espaço)", controladorCidade, codigoCidade, numero: false),
              Container(
                alignment: Alignment.center,
                height: 100,
                child: IconButton(
                  onPressed: clicouNoBotao,
                  icon: FaIcon(FontAwesomeIcons.cloud, color: Colors.blue, size: 64,),
                ),
              ),
              Componentes.rotulo(temperatura),
              Componentes.rotulo(descricao),
              Componentes.rotulo(cidade),
              Componentes.rotulo(data),
            ],
          ),
        ),
      ),
    );
  }
}