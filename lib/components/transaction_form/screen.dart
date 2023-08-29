// ignore_for_file: unnecessary_null_comparison

import 'package:expenses/components/transaction_form/widgets/select_date_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final _title = titleController.text;
    final _value = double.tryParse(valueController.text) ?? 0.0;

    if (_title.isEmpty || _value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(titleController.text,
        double.tryParse(valueController.text) ?? 0.0, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateFormatted =
        DateFormat("dd/MM/yyyy").format(_selectedDate);

    return SingleChildScrollView(
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
          SelectDateButton(
            selectedDateFormatted: selectedDateFormatted,
            selectedDate: _selectedDate,
            showDatePicker: _showDatePicker,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _submitForm,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.purple,
                  backgroundColor: Theme.of(context).primaryColorDark,
                ),
                child: Text(
                  'Nova Transação',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
