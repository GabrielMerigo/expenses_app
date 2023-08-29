import 'package:flutter/material.dart';

class SelectDateButton extends StatelessWidget {
  final void Function() showDatePicker;
  final DateTime? selectedDate;
  final String selectedDateFormatted;

  const SelectDateButton({
    required this.showDatePicker,
    required this.selectedDate,
    required this.selectedDateFormatted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Text(
              selectedDate == null
                  ? 'Nenhuma data selecionada!'
                  : 'Data Selecionada: $selectedDateFormatted',
            ),
          ),
          TextButton(
            onPressed: showDatePicker,
            child: Text(
              'Selecionar Data',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
