import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(
      titleController.text,
      double.tryParse(valueController.text) ?? 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          TextField(
            controller: titleController,
            onSubmitted: (_) => _submitForm(),
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: valueController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitForm(),
            decoration: InputDecoration(labelText: 'Valor (R\$)'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _submitForm,
                style: TextButton.styleFrom(foregroundColor: Colors.purple),
                child: Text('Nova Transação'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
