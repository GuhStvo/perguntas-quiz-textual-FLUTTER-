import 'package:flutter/material.dart';
import 'package:perguntas/components/input_form.dart';
import 'package:perguntas/components/title.dart';
import 'package:perguntas/screen/respostas.dart';
import 'package:perguntas/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 29, 128, 233)),
        useMaterial3: true,
      ),
      initialRoute: '/', // <- Splash será a rota inicial
      routes: {
        '/': (context) => const SplashScreen(), // <- Splash screen
        '/home': (context) =>
            const MyHomePage(title: 'Quiz App - Respostas Textuais'),
        '/respostas': (context) => const Respostas(),
      },
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
      if (_currentIndex < _responses.length) {
        _responses[_currentIndex] = response;
      } else {
        _responses.add(response);
      }

      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: Colors.orange,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Enviar respostas?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Ainda não')),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/respostas',
                                  arguments: _responses);
                            },
                            child: const Text('Sim, enviar'))
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
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
      body: Column(children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 0,
            end: (_currentIndex + 1) / _questions.length,
          ),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, _) => LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[300],
            color: Theme.of(context).colorScheme.primary,
            minHeight: 8,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pergunta ${_currentIndex + 1} de ${_questions.length}',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              CustomTitle(
                text: _questions[_currentIndex],
              ),
              const SizedBox(height: 20),
              InputForm(
                currentIndex: _currentIndex,
                initialValue: _currentIndex < _responses.length
                    ? _responses[_currentIndex]
                    : '',
                onSubmit: _onSubmit,
                onPrevius: _onPrevius,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
