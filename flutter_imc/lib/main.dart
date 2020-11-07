import 'package:flutter/material.dart';
import 'package:flutter_imc/uteis/componentes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();

  // Formulario de componentes
  GlobalKey<FormState> cForm = GlobalKey<FormState>();

  // Exibir mensagem
  String info = "Infome os seus dados: ";


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: criaPaginaPrincipal()
    );
  }

  criaPaginaPrincipal() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calcula IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reseraCampos,
          )
        ],
      ),
      body: criaFormularioIMC(),
    );
  }

  criaFormularioIMC() {
    return Form(
      key: cForm,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Componentes.caixaDeTexto(
                "Peso", "Digite o peso: ", controllerPeso, validaPeso,
                numero: true),
            Componentes.caixaDeTexto(
                "Altura", "Digite a altura: ", controllerAltura, validaAltura,
                numero: true),
            Componentes.botao("Calcular", calcularImc),
            Text(
              info,
              style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Function validaPeso = ((value) {
    if (value.isEmpty) {
      return "Informe o Peso:";
    }
    if (int.parse(value) <= 0) {
      return "O peso não deve ser zero ou negativo";
    }
    return null;
  });
  Function validaAltura = ((value) {
    if (value.isEmpty) {
      return "Informe a Altura:";
    }
    if (double.parse(value) <= 0) {
      return "A altura não deve ser zero ou negativa";
    }
    return null;
  });

  reseraCampos(){
    controllerPeso.text = "";
    controllerAltura.text = "";
    setState(() {
      info = "Informe os seus dados:";
      cForm = GlobalKey<FormState>();
    });
  }
  calcularImc() {
    setState(() {
      if (!cForm.currentState.validate()) {
        return null;
      }
      double p = double.parse(controllerPeso.text);
      double a = double.parse(controllerAltura.text);
      double imc = p / (a * a);
      if (imc < 18.5)
        info = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 18.5 && imc < 30)
        info = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      else
        info = "Acima do peso (${imc.toStringAsPrecision(4)})";

      print(info);
    });
  }
}
