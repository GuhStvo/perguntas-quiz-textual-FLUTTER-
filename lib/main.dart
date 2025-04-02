import 'package:flutter/material.dart';
import 'package:perguntas/components/input_form.dart';
import 'package:perguntas/components/title.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 233, 128, 29)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Quiz App - Respostas Textuais'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<String> _questions = [
    'Em Red Dead Redemption 2, qual é o nome do protagonista?',
    'Em GTA V, quantos personagens jogáveis existem na campanha?',
    'Qual é o principal banco de dados relacional usado com PHP em aplicações web?',
    'Qual sigla representa o padrão usado para estruturar páginas da web?',
    'Qual é a melhor escola de ensino técnico do Brasil?'
  ];

  final List<String> _responses = [];

  void _onSubmit(String response) {
    setState(() {
      // Se a resposta já existe, atualiza; senão, adiciona
      if (_currentIndex < _responses.length) {
        _responses[_currentIndex] = response;
      } else {
        _responses.add(response);
      }
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Quiz concluído!')),
        // );
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                  color: Colors.orange,
                ),
                child: Center(
                  child: Column(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Enviar respostar?', style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Ainda não')),
                          ElevatedButton(
                            onPressed: (){}, // Navigator até a página de de respostas certas
                            child: const Text('Sim, enviar'))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  void _onPrevius() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Pergunta ${_currentIndex + 1} de ${_questions.length}'),
            CustomTitle(text: _questions[_currentIndex]),
            InputForm(
              onSubmit: _onSubmit,
              onPrevius: _currentIndex > 0 ? _onPrevius : null,
              initialValue: _currentIndex < _responses.length
                  ? _responses[_currentIndex]
                  : null,
            ),
            if (_responses.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Respostas: ${_responses.join(", ")}'),
              ),
          ],
        ),
      ),
    );
  }
}
