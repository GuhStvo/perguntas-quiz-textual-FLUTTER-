import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  final String initialValue;
  final Function(String) onSubmit;
  final VoidCallback onPrevius;
  final int currentIndex;

  const InputForm({
    super.key,
    required this.initialValue,
    required this.onSubmit,
    required this.onPrevius,
    required this.currentIndex,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  late TextEditingController _controller;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _isButtonEnabled = widget.initialValue.trim().isNotEmpty;

    _controller.addListener(_validateInput);
  }

  void _validateInput() {
    final isFilled = _controller.text.trim().isNotEmpty;
    if (_isButtonEnabled != isFilled) {
      setState(() {
        _isButtonEnabled = isFilled;
      });
    }
  }

  @override
  void didUpdateWidget(InputForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controller.removeListener(_validateInput);
      _controller.text = widget.initialValue;
      _isButtonEnabled = widget.initialValue.trim().isNotEmpty;
      _controller.addListener(_validateInput);
      setState(() {}); // Força rebuild com novo estado do botão
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Digite sua resposta',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: widget.currentIndex == 0 ? null : widget.onPrevius,
              child: const Text('Anterior'),
            ),
            ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () => widget.onSubmit(_controller.text)
                  : null,
              child: const Text('Próxima'),
            ),
          ],
        ),
      ],
    );
  }
}
