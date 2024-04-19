import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class ContaBancaria {
  String titular;
  double saldo;

  ContaBancaria(this.titular, this.saldo);

  void depositar(double valor) {
    if (valor > 0) {
      saldo += valor;
    }
  }

  void sacar(double valor) {
    if (valor > 0 && valor <= saldo) {
      saldo -= valor;
    }
  }
}

class MyApp extends StatelessWidget {
  final ContaBancaria conta = ContaBancaria('Marcelo', 1000.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF8A05BE),
          title: Text('NUBANCO', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Color(0xFF8A05BE),
        body: BancoInterface(conta),
      ),
    );
  }
}

class BancoInterface extends StatefulWidget {
  final ContaBancaria conta;

  BancoInterface(this.conta);

  @override
  _BancoInterfaceState createState() => _BancoInterfaceState();
}

class _BancoInterfaceState extends State<BancoInterface> {
  TextEditingController _controller = TextEditingController();
  String _feedbackMessage = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Oi, ${widget.conta.titular}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Saldo atual:',
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'R\$ ${widget.conta.saldo.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Valor',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              double valor = double.tryParse(_controller.text) ?? 0.0;
              if (valor > 0) {
                widget.conta.depositar(valor);
                setState(() {
                  _controller.clear();
                  _feedbackMessage =
                      'Depósito de R\$ $valor realizado com sucesso.';
                });
              } else {
                setState(() {
                  _feedbackMessage = 'Por favor, insira um valor válido.';
                });
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              textStyle: TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Depositar'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              double valor = double.tryParse(_controller.text) ?? 0.0;
              if (valor > 0 && valor <= widget.conta.saldo) {
                widget.conta.sacar(valor);
                setState(() {
                  _controller.clear();
                  _feedbackMessage =
                      'Saque de R\$ $valor realizado com sucesso.';
                });
              } else {
                setState(() {
                  _feedbackMessage = 'Saldo insuficiente ou valor inválido.';
                });
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              textStyle: TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Sacar'),
          ),
          SizedBox(height: 10),
          Text(
            _feedbackMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
