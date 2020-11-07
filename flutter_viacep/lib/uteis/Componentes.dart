import 'package:flutter/material.dart';

class Componentes{

  static rotulo (String rotulo){
    return Text(
      rotulo,
      style: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold, fontSize: 18),
      );
  }

  static caixaDeTexto(String rotulo, String dica, TextEditingController controlador, validacao, {bool obscure=false, bool numero=false}){
    return TextFormField(
      controller: controlador,
      obscureText: obscure,
      validator: validacao,
      keyboardType: numero?TextInputType.number:TextInputType.text,
      decoration: InputDecoration(
        labelText: rotulo,
        labelStyle: TextStyle(fontSize: 18),
        hintText: dica,
        hintStyle:TextStyle(fontSize: 10, color: Colors.red),
      ),
    );
  }
  static botao(String _texto, Function _f){
    return Container(
      child: RaisedButton(
        onPressed: _f,
        child: Text(
          _texto,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black, width: 4)
        ),
        color: Colors.black87.withOpacity(0.4),
        hoverColor: Colors.black87.withOpacity(0.3),

      ),
    );
  }
}