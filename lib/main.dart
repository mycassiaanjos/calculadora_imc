import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        home: const ImcHomePage(),
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false),
  );
}

class ImcHomePage extends StatefulWidget {
  const ImcHomePage({Key? key}) : super(key: key);

  @override
  State<ImcHomePage> createState() => _ImcHomePageState();
}

class _ImcHomePageState extends State<ImcHomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = 'Peso ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 25 && imc < 30) {
        _infoText = 'Levemente acima do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 30 && imc < 35) {
        _infoText = 'Obesidade grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 35 && imc < 40) {
        _infoText = 'Obesidade grau II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade grau III (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outline,
                  color: Colors.blue[900],
                  size: 120,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Peso',
                    labelStyle: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 20,
                    ),
                    suffixText: 'kg',
                    suffixStyle: TextStyle(color: Colors.blue[900]),
                  ),
                  style: TextStyle(color: Colors.blue[900], fontSize: 25),
                  controller: weightController,
                  validator: (value) {
                    if (value!.isEmpty) return 'Insira seu peso!';
                  },
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Altura',
                    labelStyle: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 20,
                    ),
                    suffixText: 'cm',
                    suffixStyle: TextStyle(color: Colors.blue[900]),
                  ),
                  style: TextStyle(color: Colors.blue[900], fontSize: 25),
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira sua altura!';
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                Container(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blue[900],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue[900], fontSize: 25),
                )
              ],
            ),
          )),
    );
  }
}
