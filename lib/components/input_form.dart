import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  final Function(String) onSubmit;
  final VoidCallback? onPrevius;
  final String? initialValue; // Para carregar a resposta anterior, se existir

  const InputForm({
    super.key, 
    required this.onSubmit, 
    this.initialValue,
    this.onPrevius});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue); // Carrega o valor inicial, se houver
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_controller.text);
      _controller.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Sua resposta'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite sua resposta';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça os botões
              children: [
                ElevatedButton(
                  onPressed: (widget.onPrevius),
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: _validateForm,
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}