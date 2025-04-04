import 'package:flutter/material.dart';

class ContainerResposta extends StatelessWidget {
  final String pergunta;
  final String respostaUsuario;
  final String respostaCorreta;
  final bool acertou;

  const ContainerResposta({
    super.key,
    required this.pergunta,
    required this.respostaUsuario,
    required this.respostaCorreta,
    required this.acertou,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: acertou ? Colors.green[50] : Colors.red[50],
        border: Border.all(
          color: acertou ? Colors.green : Colors.red,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pergunta, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Sua resposta: "$respostaUsuario"'),
          Text('Resposta correta: "$respostaCorreta"'),
          const SizedBox(height: 4),
          Text(
            acertou ? '✔ Correta!' : '✘ Incorreta',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: acertou ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}