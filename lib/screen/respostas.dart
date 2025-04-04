import 'package:flutter/material.dart';
import 'package:perguntas/components/container-resposta.dart';
import 'package:perguntas/components/title.dart';

class Respostas extends StatelessWidget {
  const Respostas({super.key});

  @override
  Widget build(BuildContext context) {
    var responses = ModalRoute.of(context)!.settings.arguments as List<String>;

    final List<String> gabarito = [
      'arthur morgan',
      '3',
      'mysql',
      'html',
      'senac',
    ];

    final List<String> perguntas = [
      'Qual o nome do protagonista de Red Dead Redemption 2?',
      'Quanto é 1 + 2?',
      'Qual banco de dados relacional mais comum?',
      'Qual linguagem estrutura páginas web?',
      'Qual é a maior escola de ensino técnico do Brasil?',
    ];

    int totalAcertos = 0;

    for (int i = 0; i < responses.length; i++) {
      if (responses[i].trim().toLowerCase() == gabarito[i]) {
        totalAcertos++;
      }
    }

    double porcentagem = (totalAcertos / responses.length) * 100;

    void resetarRespostas() {
      responses = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App - Respostas Textuais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(text: 'Resultado do Quiz'),
            const SizedBox(height: 10),
            Text('Você acertou $totalAcertos de ${responses.length}'),
            Text(
              '${porcentagem.toStringAsFixed(1)}% de acerto',
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 20),
            const Text(
              'Respostas detalhadas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: responses.length,
                itemBuilder: (context, index) {
                  final respostaUsuario = responses[index].trim();
                  final respostaCorreta = gabarito[index];
                  final acertou =
                      respostaUsuario.toLowerCase() == respostaCorreta;

                  return ContainerResposta(
                    pergunta: perguntas[index],
                    respostaUsuario: respostaUsuario,
                    respostaCorreta:
                        '${respostaCorreta[0].toUpperCase()}${respostaCorreta.substring(1)}',
                    acertou: acertou,
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.restart_alt_outlined),
                label: const Text('Reiniciar Quiz'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
