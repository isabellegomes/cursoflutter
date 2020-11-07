import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // tira o debug
      debugShowCheckedModeBanner: false,
      home: paginaPrincipal(),
    );
  }

  paginaPrincipal() {
    return Scaffold(
      // Barra superior do app
      appBar: barraPrincipal(),
      body: Container(
        color: Colors.white,
        child: textoPrincipal(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clicouNoActionButton,
        child: Icon(Icons.add),
      ),
    );
  }

  clicouNoActionButton(){
    print("Clicou no Botão");
  }

  barraPrincipal() {
    return AppBar(
      title: Text("Olá Flutter"),
      centerTitle: true,
    );
  }

  textoPrincipal() {
    return Text(
        "Texto Principal",
      style: criaEstiloTexto(20, true, Colors.red),
    );
  }

  criaEstiloTexto(double tam, bool negrito, Color cor){
    return TextStyle(
      color: cor,
      fontSize: tam,
      fontWeight: negrito?FontWeight.bold:FontWeight.normal,
    );
  }
}
