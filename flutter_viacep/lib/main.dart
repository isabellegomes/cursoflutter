import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:viacep/uteis/Componentes.dart';

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

  TextEditingController controladorCEP = TextEditingController();
  GlobalKey<FormState> cForm = GlobalKey<FormState>();
  String rua = "Rua";
  String complemento = "Complemento";
  String bairro = "Bairro";
  String cidade = "Cidade";
  String estado = "Estado";


  Function validaCEP = (( value){
    if(value.isEmpty)
      return "Informe o CEP";

    return null;
  });

  clicouNoBotao() async{
    if (!cForm.currentState.validate())
      return ;
    String url = "https://viacep.com.br/ws/${controladorCEP.text}/json/";
    Response resposta = await get(url);
    Map endereco = json.decode(resposta.body);
    // conforme na API
    setState(() {
      rua = endereco["logradouro"];
      complemento = endereco["complemento"];
      cidade = endereco["localidade"];
      bairro = endereco["bairro"];
      estado = endereco["uf"];
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
                    "assets/imgs/logo.jpg",
                    fit: BoxFit.contain,
                ),
              ),
              Componentes.caixaDeTexto("CEP", "Informe o CEP", controladorCEP, validaCEP, numero: true),
              Container(
                alignment: Alignment.center,
                height: 100,
                child: IconButton(
                    onPressed: clicouNoBotao,
                    icon: FaIcon(FontAwesomeIcons.globe, color: Colors.green, size: 64,),
                ),
              ),
              Componentes.rotulo(rua),
              Componentes.rotulo(complemento),
              Componentes.rotulo(bairro),
              Componentes.rotulo(cidade),
              Componentes.rotulo(estado),
            ],
          ),
        ),
      ),
    );
  }
}
