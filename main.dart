import 'package:flutter/material.dart';

void main() {
  runApp(EcoConnectApp());
}

class EcoConnectApp extends StatelessWidget {
  const EcoConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoConnect',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginPage(), // Tela inicial de Login
    );
  }
}

// Tela de Login
class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login - EcoConnect')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            Center(
               child: Container(
                 child: Image.asset(
                    'assets/images/logo.png',
                    height: 120,
         ),
       ),
    ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Após login, redireciona para a Home Page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Entrar'),
            ),
            TextButton(
              onPressed: () {
                // Navega para a funcionalidade de Recuperação de Senha
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecuperarSenhaPage()),
                );
              },
              child: Text('Esqueceu a senha?'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navega para a tela de Cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroPage()),
                );
              },
              child: Text('Ainda não tem uma conta? Cadastre-se.'),
            ),
          ],
        ),
      ),
    );
  }
}

// Nova Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home - EcoConnect'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Redireciona para a tela de login ao deslogar
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo à Home Page!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Voltar para a tela anterior (neste caso, login ou outro fluxo)
                Navigator.pop(context);
              },
              child: Text('Voltar para a tela anterior'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navegar para o Simulador
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SimulatorPage()),
                );
              },
              child: Text('Ir para o Simulador de Economia'),
            ),
          ],
        ),
      ),
    );
  }
}

// Simulador Real
class SimulatorPage extends StatefulWidget {
  const SimulatorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimulatorPageState createState() => _SimulatorPageState();
}

class _SimulatorPageState extends State<SimulatorPage> {
  final TextEditingController _consumoController = TextEditingController();
  final TextEditingController _custoController = TextEditingController();
  double? economiaEstimada;

  void calcularEconomia() {
    final consumoMensal = double.tryParse(_consumoController.text);
    final custoKwh = double.tryParse(_custoController.text);

    if (consumoMensal != null && custoKwh != null) {
      final economia = consumoMensal * custoKwh * 0.3; // Economia de 30%
      setState(() {
        economiaEstimada = economia;
      });
    } else {
      setState(() {
        economiaEstimada = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulador de Economia'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Volta para a Home Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _consumoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Consumo Mensal (kWh)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _custoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Custo por kWh (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularEconomia,
              child: Text('Calcular Economia'),
            ),
            SizedBox(height: 20),
            if (economiaEstimada != null)
              Text(
                'Economia Estimada: R\$ ${economiaEstimada!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            else
              Text(
                'Insira os valores acima para calcular sua economia.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}

// Outras telas (Cadastro e Recuperação de Senha)
class CadastroPage extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro - EcoConnect')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome Completo'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class RecuperarSenhaPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  RecuperarSenhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recuperar Senha')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Enviar Link de Recuperação'),
            ),
          ],
        ),
      ),
    );
  }
}
