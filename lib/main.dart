import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsExponential(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal (${imc.toStringAsExponential(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso (${imc.toStringAsExponential(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsExponential(4)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsExponential(4)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III (${imc.toStringAsExponential(4)})';
      } else {
        _infoText = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  _resetFields();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(
                  Icons.person_outline,
                  color: Colors.green,
                  size: 120,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  validator: (value) {
                    if (weightController.text.isEmpty) {
                      return 'Insira seu peso';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.green),
                    hintText: 'Insira seu peso',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    )),
                  ),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.email),
                ),
                const SizedBox(height: 60),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (heightController.text.isEmpty) {
                      return 'Insira sua altura';
                    }
                  },
                  controller: heightController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green),
                    hintText: 'Insira sua altura',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    )),
                  ),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.email),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          calculate();
                        }
                      });
                    },
                    child: const Text('Calcular'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(24),
                    )),
                const SizedBox(height: 60),
                Text(_infoText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green)),
              ]),
        ),
      ),
    );
  }
}
